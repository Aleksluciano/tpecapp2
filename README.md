# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

MAC/LINUX
mkdir -p tpecapp && cd tpecapp && touch db.sqlite && curl -O https://raw.githubusercontent.com/Aleksluciano/tpecapp2/main/docker-compose.yml && docker pull aleksluciano/tpecapp:v1.1 && docker compose up -d

WINDOWS
mkdir tpecapp && cd tpecapp && type nul > db.sqlite && curl -O https://raw.githubusercontent.com/Aleksluciano/tpecapp2/main/docker-compose.yml && docker pull aleksluciano/tpecapp:v1.1 && docker compose up -d
