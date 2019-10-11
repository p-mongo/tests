# Driver Recovery Tests

These tests verify the driver's behavior when nodes in a deployment become
unavailable, or change state.

## Client Test

This test uses a client instance from many threads concurrently, performing
concurrent reads.

    bundle install
    ./test-client path-to-config-file

The URI can be to a replica set or sharded custer deployment with a minimum of
two nodes.

## Driver Version

`master` branch of the Ruby driver contains the most diagnostics. The test
will work with older driver versions but will not provide as much diagnostics.
`Gemfile` is configured to use driver `master` by default.

## Ruby Version

These tests can be run with MRI or JRuby. The two interpreters behave
differently in how concurrent they are, and thus the profile of execution,
but the error behavior should generally be the same.

## Deployment

The test assumes an externally provisioned deployment. Local deployments with
various configurations can be obtained following instructions in the
[driver spec readme](https://github.com/mongodb/mongo-ruby-driver/blob/master/spec/README.md).

Pass the MongoDB URI to the deployment as the first argument to the test being
run.

There are some helper scripts to create specific deployments:

- [Big sharded cluster](https://github.com/p-mongo/dev/blob/master/script/launch-4.4-sharded-big) -
2 shards x 2 RS nodes each, 10 mongos routers.

## Deployment Events

Here are some handy commands when working with local deployments.

Kill whatever is listening on port 14440 (mongod or mongos):

    ps awwxu |grep 14440 |awk '{print $2}' |xargs kill

Drop (blackhole) all traffic to port 14440:

    iptables -A INPUT -p tcp --destination-port 14440 -j DROP

Cancel dropping traffic:

    iptables -D INPUT -p tcp --destination-port 14440 -j DROP

## Test Output

The tests show the current state of the driver. Example output:

    2019-08-01 13:16:15 -0400: 623 read ops, 21 alive threads, 0 exceptions
    #<Cluster topology=Sharded[localhost:14440,localhost:14441] servers=[#<Server address=localhost:14440 UNKNOWN>,#<Server address=localhost:14441 MONGOS pool=#<ConnectionPool size=10 (0-10) used=10 avail=0 pending=0>>]>

This output shows:

- Current operations being executed by the driver (reads, 623 reads in the last
second).
- How many worker threads are running. This normally should stay constant for
the duration of the test; dying worker threads typically indicate a problem
with the test.
- How many exceptions have been rescued by the worker, and consequently,
raised by the driver. If there are no exceptions raised, the driver handles
any errors internally without failing application operations.
- The current topology, and a summary of all servers known to the driver along
with statistics on each server's connection pool.

Additionally, the tests create log file(s) in the current directory with all
logging output that the driver generates during each run.
