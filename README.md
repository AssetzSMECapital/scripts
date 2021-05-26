# Scripts

Note: This repository is **public**!

To add a script to a build:

- Create a command line step
- Give it a name
- Add the following

```bash
#!/bin/bash
SCRIPT_BRANCH="develop"
SCRIPT_DIRECTORY="dir/"
SCRIPT_NAME="test.sh"
source <(curl -s "https://raw.githubusercontent.com/AssetzSMECapital/scripts/$SCRIPT_BRANCH/$SCRIPT_DIRECTORY$SCRIPT_NAME")
```

```bash
#!/bin/bash
SCRIPT_BRANCH="develop"
SCRIPT_DIRECTORY="dir/"
SCRIPT_NAME="test.sh"

curl -o $SCRIPT_NAME "https://raw.githubusercontent.com/AssetzSMECapital/scripts/$SCRIPT_BRANCH/$SCRIPT_DIRECTORY$SCRIPT_NAME" && \
ls && \
echo "$SCRIPT_NAME" && \
chmod +x $SCRIPT_NAME && \
cat $SCRIPT_NAME && \
./$SCRIPT_NAME && \
rm $SCRIPT_NAME
```
