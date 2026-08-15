# Employee Engagement

Employee self-service for reimbursements and leave requests. Rails 8 + PostgreSQL, with an ActiveAdmin back office.

## Requirements

- Ruby >= 3.3.5 (see `.ruby-version`)
- Rails >= 8.0.0
- Node.js >= 18 and Yarn 1.x (JS/CSS bundling via `jsbundling-rails` / `cssbundling-rails`)
- PostgreSQL

## Local development

```bash
git clone https://github.com/loudcloud-dev/ee_calculator.git
cd ee_calculator
bundle install
yarn install
```

Set the environment variables the app reads from `config/database.yml`:

```bash
export POSTGRESQL_USERNAME=<db user>
export POSTGRESQL_PASSWORD=<db password>
export POSTGRESQL_HOST=localhost
```

## Database setup

```bash
bin/rails db:prepare
bin/rails db:seed
```

## Run the app

```bash
bin/dev
```

The app listens on <http://localhost:3000>.

## Tests and lint

```bash
bundle exec rspec
bundle exec rubocop
```

## Docker (production image)

Build and run by hand:

```bash
$ docker build -t employee-engagement .
$ docker run -d -p 3000:3000 --name employee-engagement \
    -e RAILS_MASTER_KEY=<value from config/master.key> \
    -e POSTGRESQL_USERNAME=<db user> \
    -e POSTGRESQL_PASSWORD=<db password> \
    -e POSTGRESQL_HOST=localhost \
    employee-engagement
```

The image is a multi-stage build that:

- compiles the `pg` gem against `libpq-dev` and runs on `libpq5`,
- installs JS/CSS dependencies with Yarn and precompiles assets with Node, then drops `node_modules` from the runtime image,
- runs as an unprivileged `rails` user,
- uses `bin/docker-entrypoint`, which runs `bin/rails db:prepare` before booting the server.

## Production deployment (Coolify)

| Setting | Value |
|---|---|
| Build method | Dockerfile (this repo) |
| Port | `3000` |
| Health check path | `GET /up` (unauthenticated; returns 200 once booted) |
| Start command | `sh -c 'bin/rails db:migrate && bin/rails server -b 0.0.0.0'` |

### Environment variables

| Variable | Required | Notes |
|---|---|---|
| `RAILS_MASTER_KEY` | yes (or `SECRET_KEY_BASE`) | decrypts `config/credentials.yml.enc`; there is no `config/master.key` in the repo |
| `POSTGRESQL_USERNAME` | yes | from the Coolify PostgreSQL service |
| `POSTGRESQL_PASSWORD` | yes | from the Coolify PostgreSQL service |
| `POSTGRESQL_DATABASE` | no | defaults to `postgres` |
| `POSTGRESQL_HOST` | no | defaults to `localhost`; set to the Coolify PostgreSQL service host in production |
| `HTTP_AUTH_USERNAME` | no | enables HTTP basic auth on the public reimbursements pages; must be set together with `HTTP_AUTH_PASSWORD` |
| `HTTP_AUTH_PASSWORD` | no | see `HTTP_AUTH_USERNAME` |
| `PORT` | no | defaults to `3000` |
| `RAILS_MAX_THREADS` | no | defaults to `3` |

### Persistent volumes

- `/rails/storage` — Active Storage is configured to `:local` (`config/environments/production.rb:40`). Without a volume, uploads are lost on redeploy.

### Deployment notes / known issues

1. **`config.force_ssl = true`** redirects plain-HTTP requests to HTTPS. The Coolify internal health check hits the app over HTTP; if it reports 30x/failing, disable `force_ssl` (TLS terminates at the Coolify proxy) or point the health check at the HTTPS listener. A ready-made exclude for `/up` is commented at `config/environments/production.rb:55`.
3. **SMTP credentials are optional at boot** — `config.action_mailer.smtp_settings` reads them via `credentials.dig`, so the app starts without a `smtp` key, but email delivery requires adding `smtp.username`/`smtp.password` to `config/credentials.yml.enc`.
4. Coolify builds from git, not the working tree — commit and push Dockerfile changes before triggering the first deploy from the Coolify UI.
