This uses Packer with the [OpenStack plugin](https://www.packer.io/plugins/builders/openstack) to automate interaction with Nectar to build a base image for deployment of [traitecoevo/austraits-api-nectar](https://github.com/traitecoevo/austraits-api-nectar).

To run locally:

- [Install Packer](https://www.packer.io/downloads)
- Create a variables file `{somename}.auto.pkrvars.hcl` setting variables as defined in `austraits-api-base.pkr.hcl` with values from Nectar project to use for build:
```
source_image = "{put image id here}"
... etc ...
```
- Source credentials for this Nectar project into environment (see [Setting up your credentials](https://tutorials.rc.nectar.org.au/openstack-cli/04-credentials))
- `$ packer build .`
