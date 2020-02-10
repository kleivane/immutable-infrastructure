# terraform-aws-cloudfront-s3-assets

Oppretter cloudfront-config for
* assets/ pekende til en standard felles S3-bucket for genererte assets
* bucket som inneholder annet inneholder

Begge har konfigureres til å støtte cache headers som kommer fra bøttene.
Modulen er laget for å støtte opp under immutable-webapps-applikasjonen.

Felles ressurs
- S3 bucket for genererte assets
