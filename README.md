# sonarqube-synology

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

This repository provides a script for simple installation of sonarqube in Synology.  
The script was tested in DSM 7.0.
## Table of Contents
- [Known Issues](#known-issues)
- [Install](#install)
- [Usage](#usage)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)
## Known Issues
### vm.max_map_count [65530] is too low, increase to at least
When Synology is rebooted, the following log appears.
> [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```bash
ssh ...
sudo -i
sysctl -w vm.max_map_count=524288
```
## Install

```bash
$ ssh -p [port] username@url
$ wget https://github.com/zxc010613/sonarqube-synology/blob/main/install.sh
$ wget https://github.com/zxc010613/sonarqube-synology/blob/main/docker-compose.yml
```

## Usage
Before you begin, you need to change the installation path.  
(6 line)  
Default value `/volume1/docker`, is shared folder.  
The final installation path is as follows.  
`/volume1/docker/sonarqube`
```bash
vi install.sh
```
```bash
sudo -i
sh install.sh
```


## Maintainers

[@zxc010613](https://github.com/zxc010613)

## Contributing

PRs accepted.


## License

MIT © 2020 Plorence
