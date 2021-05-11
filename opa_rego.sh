#!/bin/bash
# prints the input
function rego() {
  docker run openpolicyagent/opa eval $1
}

function regoenv(){
  docker run -v $PWD:/example openpolicyagent/opa eval -d /example -i /example/input.json $1
}
