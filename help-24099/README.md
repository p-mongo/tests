## Atlas test

```
serene% echo "GET http://localhost:9292/api/sample?secondaryRedirectionPercentage=100" | vegeta attack -rate=10/1s -duration 10s | vegeta report
Requests      [total, rate, throughput]         100, 10.10, 10.06
Duration      [total, attack, wait]             9.942s, 9.9s, 41.7ms
Latencies     [min, mean, 50, 90, 95, 99, max]  38.185ms, 47.822ms, 47.307ms, 53.957ms, 56.976ms, 60.539ms, 61.265ms
Bytes In      [total, mean]                     134404, 1344.04
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:100  
Error Set:
serene% echo "GET http://localhost:9292/api/sample?secondaryRedirectionPercentage=0" | vegeta attack -rate=10/1s -duration 10s | vegeta report 
Requests      [total, rate, throughput]         100, 10.10, 10.06
Duration      [total, attack, wait]             9.937s, 9.9s, 36.768ms
Latencies     [min, mean, 50, 90, 95, 99, max]  31.612ms, 39.722ms, 39.645ms, 43.948ms, 45.568ms, 48.107ms, 49.318ms
Bytes In      [total, mean]                     133694, 1336.94
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:100  
Error Set:
```

## Local 4.9 RS ("used")

```
serene% echo "GET http://localhost:9292/api/sample?secondaryRedirectionPercentage=0" | vegeta attack -rate=10/1s -duration 10s | vegeta report
Requests      [total, rate, throughput]         100, 10.10, 0.00
Duration      [total, attack, wait]             9.905s, 9.9s, 5.467ms
Latencies     [min, mean, 50, 90, 95, 99, max]  4.09ms, 5.532ms, 5.565ms, 5.732ms, 5.901ms, 7.319ms, 7.675ms
Bytes In      [total, mean]                     2100, 21.00
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           0.00%
Status Codes  [code:count]                      404:100  
Error Set:
404 Not Found
serene% echo "GET http://localhost:9292/api/sample?secondaryRedirectionPercentage=100" | vegeta attack -rate=10/1s -duration 10s | vegeta report
Requests      [total, rate, throughput]         100, 10.10, 0.00
Duration      [total, attack, wait]             9.906s, 9.9s, 5.492ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.234ms, 5.607ms, 5.639ms, 6.071ms, 6.394ms, 8.576ms, 9.162ms
Bytes In      [total, mean]                     2100, 21.00
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           0.00%
Status Codes  [code:count]                      404:100  
Error Set:
404 Not Found
```
