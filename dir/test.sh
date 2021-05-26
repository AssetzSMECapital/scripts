#!/bin/bash

echo "Hello world from a directory!"
echo "%teamcity.serverUrl%"
echo "##teamcity[setParameter name='env.DOCKER_TAG' value='1234']"
