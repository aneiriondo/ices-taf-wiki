
* [List your analyses](#list-your-analyses)
* [List expert group analyses](#list-expert-group-analyses)
* [List all public analyses](#list-all-public-analyses)
* [Create analysis](#create-analysis)
* [Get analysis](#get-analysis)


The Analysis API allows you to list, view, edit, and create TAF analyses.

## List your analyses

```
GET user/analyses
```

### Response

```
Status: 200 OK
```

```json
[
  {
    "stuff": "goes here"
  }
]
```

## List expert group analyses

```
GET egs/:eg_id/analyses
```

### Response

```
Status: 200 OK
```

```json
[
  {
    "stuff": "goes here"
  }
]
```


## List all public analyses

List all publicly available stock assessment analyses

```
GET /stockassessments
```

### Response

```
Status: 200 OK
```

```json
[
  {
    "stuff": "goes here"
  }
]
```


## Create analysis

When an analysis is created the following steps occur:
* A GitHub repository is created on [github.com/ices-taf](https:://github.com/ices-taf)
* An issue is created with a list of tasks required
* The issue is added to the [TAF project board](https://github.com/ices-taf/doc/projects/2)
* The approprate expert group is given access to the repository
* Two branches are created: taf and clean, which are controlled by the TAF server in ICES,
  and will be where the official version of the analysis and its results will be made available.

```
POST /analysis
```

### Parameters

| Name  | Type | Description |
| ------------- | ------------- | ---------- |
| `StockKeyLabel`  | `string`  | **Required**. The stock code (see link-to-vocab). |
| `ActiveYear`  | `int`  | **Required**. The year the stock assessment is being conducted in (i.e. the current year). |

#### Example

```json
{
  "StockKeyLabel": "lez.27.4a6a",
  "ActiveYear": 2018
}
```

### Response

```
Status: 201 Created
```

```json
{
  "message": "Created analysis 2018_lez.27.4a6a",
  "analysis_url": "https://github.com/ices-taf/2018_lez.27.4a6a"
}
```

## Get analysis

```
GET /analysis/:analysis
```

### Response

```
Status: 200 OK
```

```json
{
  "stuff": "goes here"
}
```
