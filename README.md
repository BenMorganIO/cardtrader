# CardTrader

It's a ruby script to help me manage my inventory on CardTrader. The script expects to be executed in an `irb` environment.

## Setup

Place your CardTrader auth token in the `CARDTRADER_TOKEN` environment variable. I used a `.env` file and then `source .env`:

```bash
# .env
export CARDTRADER_TOKEN='asdf123'
```

## Product CSV Export

Exports a CSV into a tmp folder.

```ruby
require_relative 'lib/trader'
Trader.export_csv
```
