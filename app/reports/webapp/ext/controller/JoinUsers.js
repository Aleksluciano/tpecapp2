sap.ui.define(
  ["sap/m/MessageToast", "sap/ui/export/Spreadsheet", "sap/ui/export/library"],
  function (MessageToast, Spreadsheet, exportLibrary) {
    "use strict";

    const EdmType = exportLibrary.EdmType;

    function formatDatePtBR(dateValue) {
      if (!dateValue) return "";

      // Se já for uma string, tenta converter para data
      const date = dateValue instanceof Date ? dateValue : new Date(dateValue);

      // Verifica se é uma data válida
      if (isNaN(date.getTime())) return dateValue;

      // Formata para dd/mm/yyyy
      const day = date.getDate().toString().padStart(2, "0");
      const month = (date.getMonth() + 1).toString().padStart(2, "0");
      const year = date.getFullYear();

      return `${day}/${month}/${year}`;
    }

    function createCustomColumnConfig() {
      return [
        {
          label: "Escala",
          property: "schedule_name",
          type: EdmType.String,
        },
        {
          label: "Dia",
          property: "day",
          type: EdmType.String,
        },
        {
          label: "Dia da semana",
          property: "dayweek_day",
          type: EdmType.String,
        },
        {
          label: "Ponto",
          property: "point_name",
          type: EdmType.String,
        },
        {
          label: "Período",
          property: "period_descr",
          type: EdmType.String,
        },
        {
          label: "Publicadores",
          property: "user_names", // Note que mudamos para "user_names" (plural)
          type: EdmType.String,
        },
        // A coluna "Sexo" foi removida
      ];
    }

    function groupAndTransformData(aData) {
      // Primeiro, criamos um mapa para agrupar por combinação de valores
      const groupedMap = new Map();

      aData.forEach((item) => {
        // Cria uma chave única baseada nos 5 campos para agrupar
        // Formata a data antes de usar na chave
        const formattedDay = formatDatePtBR(item.day);

        const key = [
          item?.schedule_name || "",
          formattedDay,
          item.dayweek?.day || "",
          item.point?.name || "",
          item.period?.descr || "",
        ].join("|||"); // Usa um separador improvável para formar a chave

        // Obtem a entrada existente ou cria uma nova
        if (!groupedMap.has(key)) {
          groupedMap.set(key, {
            schedule_name: item?.schedule_name || "",
            day: formattedDay, // Usa a data já formatada
            dayweek_day: item.dayweek?.day || "",
            point_name: item.point?.name || "",
            period_descr: item.period?.descr || "",
            users: [], // Array para armazenar os nomes dos usuários
          });
        }

        // Adiciona o nome do usuário se ele existir
        const userName = item.user?.name || "";
        if (userName && groupedMap.get(key).users.indexOf(userName) === -1) {
          groupedMap.get(key).users.push(userName);
        }
      });

      // Converte o mapa para um array e formata os nomes dos usuários
      const result = Array.from(groupedMap.values()).map((group) => {
        return {
          ...group,
          user_names: group.users.join(" / "), // Junta os nomes com " / "
        };
      });

      // Após criar o array result, mas antes de retorná-lo
      result.sort((a, b) => {
        // Converte as strings de data formatadas de volta para objetos Date para comparação
        const dateA = a.day.split("/").reverse().join("-");
        const dateB = b.day.split("/").reverse().join("-");
        return new Date(dateA) - new Date(dateB);
      });

      return result;
    }

    function functionJoinUsers(oEvent) {
      const oTable = sap.ui
        .getCore()
        .byId(
          "ns.reports::ReportsList--fe::table::Reports::LineItem-innerTable"
        );

      if (oTable) {
        const oBinding = oTable.getBinding("items");

        if (oBinding) {
          const aContexts = oBinding.getCurrentContexts();
          const aData = aContexts.map(function (oContext) {
            return oContext.getObject();
          });

          console.log("Todos os dados da tabela:", aData);

          if (aData.length > 0) {
            // Agrupa e transforma os dados
            const aTransformedData = groupAndTransformData(aData);
            console.log("Dados agrupados e transformados:", aTransformedData);

            // Obtém a configuração de colunas customizada
            const aColumns = createCustomColumnConfig();

            const oSettings = {
              workbook: {
                columns: aColumns,
                hierarchyLevel: "Level",
                sheetName: "Relatório de Escala",
              },
              dataSource: aTransformedData,
              fileName: "Relatorio_Escala.xlsx",
              worker: false,
            };

            const oSpreadsheet = new Spreadsheet(oSettings);
            oSpreadsheet
              .build()
              .then(function () {
                MessageToast.show("Relatório exportado com sucesso!");
              })
              .catch(function (oError) {
                console.error("Erro ao exportar o relatório", oError);
                MessageToast.show("Erro ao exportar: " + oError.message);
              });
          } else {
            MessageToast.show("Nenhum dado para exportar.");
          }
        } else {
          console.error("Binding dos items não encontrado!");
          MessageToast.show("Não foi possível acessar os dados da tabela.");
        }
      } else {
        console.error("Tabela não encontrada!");
        MessageToast.show("Tabela não encontrada. Tente novamente.");
      }
    }

    // Retorna um objeto com referências às funções definidas acima
    return {
      functionJoinUsers: functionJoinUsers,
    };
  }
);
