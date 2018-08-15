
The Expert Groups API allows you to list, view, edit, and create expert groups.  Expert groups
function like teams and are a way to give groups of TAF users access to analyses of interest to
their expert group.  A TAF user can be a member of multiple expert groups.

## List Expert Groups

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
