#!/bin/bash

curl -XPOST 127.0.0.1:8000 \
-H 'content-type:application/json' \
-d '{
    "clue_createtime":"2022-7-20 10:58:33",
    "app":"Chaos Mesh",
    "city":"here"
}' \
