# go-virtualenv-script
Script for download Go and activate a python like virtualenv. This is a working draft with plenty of bugs so feel free to fork it :D .  

#### Usage
Just put the file at the root of the new project and execute this command to activate the virtualenv:
```bash
source activate.sh
```
This will download and extract the go archive from the link defined in the script if the bin folder doesn't exist.
After the download it will activate the go virtualenv.

To desactivate, just type:
```bash
deactivate
```
#### Contributors
 * Thanks to [Dimitri S](https://github.com/midse)
