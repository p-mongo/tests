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

## Atlas test with find_one instead of aggregation+$sample

```
serene% ab -n 500 'http://localhost:9292/api/sample?secondaryRedirectionPercentage=100' 
This is ApacheBench, Version 2.3 <$Revision: 1879490 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Finished 500 requests


Server Software:        thin
Server Hostname:        localhost
Server Port:            9292

Document Path:          /api/sample?secondaryRedirectionPercentage=100
Document Length:        191821 bytes

Concurrency Level:      1
Time taken for tests:   7.406 seconds
Complete requests:      500
Failed requests:        496
   (Connect: 0, Receive: 0, Length: 496, Exceptions: 0)
Non-2xx responses:      500
Total transferred:      97634230 bytes
HTML transferred:       97574230 bytes
Requests per second:    67.51 [#/sec] (mean)
Time per request:       14.812 [ms] (mean)
Time per request:       14.812 [ms] (mean, across all concurrent requests)
Transfer rate:          12874.53 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:    11   15  11.1     13     242
Waiting:       11   15  11.1     13     242
Total:         11   15  11.1     13     242

Percentage of the requests served within a certain time (ms)
  50%     13
  66%     14
  75%     14
  80%     14
  90%     15
  95%     30
  98%     33
  99%     33
 100%    242 (longest request)
serene% ab -n 500 'http://localhost:9292/api/sample?secondaryRedirectionPercentage=0'   
This is ApacheBench, Version 2.3 <$Revision: 1879490 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Finished 500 requests


Server Software:        thin
Server Hostname:        localhost
Server Port:            9292

Document Path:          /api/sample?secondaryRedirectionPercentage=0
Document Length:        195425 bytes

Concurrency Level:      1
Time taken for tests:   7.237 seconds
Complete requests:      500
Failed requests:        142
   (Connect: 0, Receive: 0, Length: 142, Exceptions: 0)
Non-2xx responses:      500
Total transferred:      98030546 bytes
HTML transferred:       97970546 bytes
Requests per second:    69.09 [#/sec] (mean)
Time per request:       14.473 [ms] (mean)
Time per request:       14.473 [ms] (mean, across all concurrent requests)
Transfer rate:          13228.89 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:    12   14   4.4     13      35
Waiting:       12   14   4.4     13      35
Total:         12   14   4.4     13      35

Percentage of the requests served within a certain time (ms)
  50%     13
  66%     14
  75%     14
  80%     14
  90%     15
  95%     30
  98%     33
  99%     33
 100%     35 (longest request)
```
