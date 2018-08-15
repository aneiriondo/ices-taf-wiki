
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
  "analyses_url": "https://taf.ices.local/egs/1/analyses"
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

### Example

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
  "analyses_url": "https://taf.ices.local/egs/1/analyses"
  "members_count": 3,
  "repos_count": 10
}
```
