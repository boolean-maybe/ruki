# ruki

ruki is a small query and trigger language for document collections. A host supplies a field schema and a
document type; ruki parses, validates, and executes `select` / `update` / `create` / `delete` statements and
event/time triggers against the host's documents.

## Install

```
go get github.com/boolean-maybe/ruki
```

## Concepts

- **`ruki.Document`** — the document ruki reads and mutates. Implement it on your own type (id/title/body/
  path/timestamps accessors + a generic `Get`/`Set`/`Has`/`Delete` field map + `Clone`).
- **`ruki.Schema`** — the field catalog. Implement `Field(name) (FieldSpec, bool)` so ruki knows each field's
  type (string, int, enum, recurrence, …).
- **`ruki.DocumentFactory`** — builds a blank `Document` for `create` statements.

## Quick start

```go
parser := ruki.NewParser(schema) // schema implements ruki.Schema
vs, err := parser.ParseAndValidateStatement(
	`select where status = "open"`, ruki.ExecutorRuntimeCLI)
if err != nil {
	// handle parse/validation error
}

exec := ruki.NewExecutor(schema, factory, userFunc, ruki.ExecutorRuntime{Mode: ruki.ExecutorRuntimeCLI})
res, err := exec.Execute(vs, docs) // docs is []ruki.Document
// res.Select / res.Update / res.Create / res.Delete carry the outcome
```

See the package docs for `Parser`, `Executor`, triggers (`ParseAndValidateTrigger`), and the
`recurrence` / `duration` / `idfmt` / `collections` helper packages.
