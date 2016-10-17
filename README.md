# Simple Conekta API

## How to run

```
git clone git@github.com:Kentverger/labConekta.git
bundle install
```

to run the test suit run:
`rspec`

## API endpoints

Simple API to process online payments.

## Cards [/cards]

### Tokenization [POST /cards/actions/tokenize]

+ Request (application/json)

        {
            "name": "Luis Carlos González Hernández",
            "number": 42424242424242424242,
            "cvv": 123,
            "experiation_month": 12,
            "experiation_year": 2019,
            "customer_id": 1
        }

+ Response 200 (application/json)

        {
            "name": "Luis Carlos Gonzalez Hernandez",
            "schema": "debit",
            "brand": "MC",
            "last_four": 4242,
            "token": "tok_asf3efefvdfd3sd",
            "created_at": "2015-10-17T09:30:00.620Z",
            "expires_at": "2015-10-17T09:40:00.620Z",
            "status": "active"
        }

+ Response 500 (application/json)

        {
            "errors": [
                "Expiration month is invalid",
                "Expiration year is the past",
                "Card number is invalid",
                "Name can't be blank",
                "Number can't be blank",
                "CVV can't be blank",
            ]
        }

## Charges [/charges]

### Create charge [POST]

+ Request (application/json)

        {
            "amount": 1549,
            "fee": 10,
            "total_amount": 1559,
            "description": "Compras en Liverpool",
            "card_token": "tok_asf3efefvdfd3sd",
            "details": {
                "customer_id": 1,
                "line_items": [
                    "name": "Tennis Converse",
                    "price": 659,
                    "quantity": 1,
                    "sku": 12332342443434
                ], [
                    "name": "Pantalones levis",
                    "price": 890,
                    "quantity": 1,
                    "sku": 12332342443434
                ]
            }
        }

+ Response 200 (application/json)

        {
            "amount": 200,
            "fee": 10,
            "total_amount": 200,
            "name": "Tenis converse",
            "card": {
                "name": "Luis Carlos Gonzalez Hernandez",
                "schema": "debit",
                "brand": "MC",
                "last_four": 4242,
                "token": "tok_asf3efefvdfd3sd",
                "created_at": "2015-10-17T09:30:00.620Z",
                "expires_at": "2015-10-17T09:40:00.620Z",
                "status": "active"
            }
        }

+ Response 500 (application/json)

        {
            "errors": [
                "Insufficient balance",
                "Declined by the bank",
                "Amount can't be blank",
                "Fee can't be blank",
                "Total amount can't be blank",
                "Description can't be blank",
                "Card token can't be blank",
                "Card token is expired",
            ]
        }

## Customers [/customers]

### Create [POST]

+ Request (application/json)

            {
                "name": "Luis Carlos Gonzalez Hernandez",
                "address": "Loma Azul 476 Loma Blanca",
                "phone": "4442123489"
            }

+ Response 200 (application/json)

            {
                "id": 1,
                "name": "Luis Carlos Gonzalez Hernandez",
                "address": "Loma Azul 476 Loma Blanca",
                "phone": "4442123489"
            }

+ Response 500 (application/json)

            {
                "errors": [
                    "Name can't be blank",
                    "Address can't be blank",
                    "Phone can't be blank",
                ]
            }

### Cards [GET /customers/:id/cards]

+ Response 200 (application/json)

        [{
            "name": "Luis Carlos Gonzalez Hernandez",
            "schema": "debit",
            "brand": "MC",
            "last_four": 4242,
            "token": "tok_asf3efefvdfd3sd",
            "created_at": "2015-10-17T09:30:00.620Z",
            "expires_at": "2015-10-17T09:40:00.620Z",
            "status": "active"
        }]

### Charges [GET /customers/:id/charges]

+ Response 200 (application/json)

        [{
            "amount": 200,
            "fee": 10,
            "total_amount": 200,
            "name": "Tenis converse",
            "card": {
                "name": "Luis Carlos Gonzalez Hernandez",
                "schema": "debit",
                "brand": "MC",
                "last_four": 4242,
                "token": "tok_asf3efefvdfd3sd",
                "created_at": "2015-10-17T09:30:00.620Z",
                "expires_at": "2015-10-17T09:40:00.620Z",
                "status": "active"
            }
        }]
