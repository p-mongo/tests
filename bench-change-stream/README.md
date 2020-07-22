# Change Stream Benchmark

Run insert.rb or update.rb, then run read.rb.

Logs:

- [insert log](https://gist.github.com/p-mongo/63e4e2e7507620fc45256224b9b43fa7)
- [read log](https://gist.github.com/p-mongo/bb44c1aa7753fbaa8ece1e2f8938bde7)

Update perf on serene: ~12k doc/s sustained

Insert perf on serene: ~17k doc/s sustained

3 node RS, database running in zram, i5-4460S, database is CPU bound with writes.
