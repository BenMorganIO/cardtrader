# CardTrader

It's a ruby script to help me manage my inventory on CardTrader. The script expects to be executed in an `irb` environment.

## Product CSV Export

Exports a CSV into a tmp folder.

```ruby
require_relative 'lib/trader'
Trader.export_csv
```
