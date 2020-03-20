
* [List expert groups](#list-expert-groups)
* [Get expert group](#get-expert-group)
* [Create expert group](#create-expert-group)
* [List expert group analyses](#list-expert-group-analyses)
* [Add or update expert group analysis](#add-or-update-expert-group-analysis)
* [Remove expert group analysis](#remove-expert-group-analysis)


The Expert Groups API allows you to list, view, edit, and create expert groups.  Expert groups
function like teams and are a way to give groups of TAF users access to analyses of interest to
their expert group.  A TAF user can be a member of multiple expert groups.

## List expert groups

```
GET /egs
```

### Response

```
Status: 200 OK
```

```json
[
  {
    "id": 1,
    "url": "https://taf.ices.local/egs/1",
    "name": "WGCSE",
    "description": "Working Group for the Celtic Seas Ecoregion",
    "analyses_url": "https://taf.ices.local/egs/1/analyses"
  }
]
```

## Get expert group

```
GET /egs/1
```

### Response

```
Status: 200 OK
```

```json
{
  "id": 1,
  "url": "https://taf.ices.local/egs/1",
  "name": "WGCSE",
  "description": "Working Group for the Celtic Seas Ecoregion",
  "analyses_url": "https://taf.ices.local/egs/1/analyses",
  "members_count": 3,
  "repos_count": 10
}
```

## Create expert group

To create an expert group, the user must be authenticated with sufficient priveledges

```
POST /egs
```

### Parameters

| Name  | Type | Description |
| ------------- | ------------- | ---------- |
| `name`  | `string`  | **Required**. The name of the expert group. |
| `description`  | `string`  | The full name of the expert group. |

#### Example

```json
{
  "name": "WGCSE",
  "description": "Working Group for the Celtic Seas Ecoregion"
}
```

### Response

```
Status: 201 Created
```

```json
{
  "id": 1,
  "url": "https://taf.ices.local/egs/1",
  "name": "WGCSE",
  "description": "Working Group for the Celtic Seas Ecoregion",
  "analyses_url": "https://taf.ices.local/egs/1/analyses",
  "members_count": 3,
  "repos_count": 10
}
```

## List expert group analyses

```
GET egs/:eg_id/analyses
```

### Response

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

## Add or update expert group analysis

```
PUT /egs/:eg_id/analyses/:analysis
```

### Parameters

| Name  | Type | Description |
| ------------- | ------------- | ---------- |
| `permission`  | `string`  | Either `read` or `write`. \n  if no body is provided then `read` will be assumed. |

### Response

```
Status: 204 No Content
```

## Remove expert group analysis

```
DELETE /egs/:eg_id/analyses/:analysis
```

### Response

```
Status: 204 No Content
```


