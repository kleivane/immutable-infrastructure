# immutable-infrastructure
Terraform infrastructure for immutable webapp &amp; friends

## Running
For å kjøre terraform må du sette [environment-variable](https://www.terraform.io/docs/providers/aws/index.html) for access til aws.

## Gode prinsipper
* Deploy av kode og infrastruktur skal skje fra ci
* Utviklere skal ha rettigheter som ikke stopper dem fra å teste og utforske
* Prod skal ha annen tilgangsstyring enn test
* Bygget kode skal kunne deployes til alle miljøer - config skal leve et annet sted
* ...
