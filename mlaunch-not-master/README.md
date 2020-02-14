# mlaunch not master test

Error:

<pre>
+ mlaunch --dir /tmp/db --setParameter diagnosticDataCollectionEnabled=false --replicaset --sharded 2 --name ruby-driver-rs --mongos 2 --auth --username bob --password pwd123
launching: "mongod" on port 27019
launching: "mongod" on port 27020
launching: "mongod" on port 27021
launching: "mongod" on port 27022
launching: "mongod" on port 27023
launching: "mongod" on port 27024
launching: config server on port 27025
replica set 'configRepl' initialized.
replica set 'shard01' initialized.
replica set 'shard02' initialized.
launching: mongos on port 27017
launching: mongos on port 27018
adding shards. can take up to 30 seconds...
Traceback (most recent call last):
  File "/root/.local/bin/mlaunch", line 11, in <module>
    sys.exit(main())
  File "/root/.local/lib/python3.6/site-packages/mtools/mlaunch/mlaunch.py", line 2068, in main
    tool.run()
  File "/root/.local/lib/python3.6/site-packages/mtools/mlaunch/mlaunch.py", line 542, in run
    getattr(self, self.args['command'])()
  File "/root/.local/lib/python3.6/site-packages/mtools/mlaunch/mlaunch.py", line 773, in init
    roles=roles)
  File "/root/.local/lib/python3.6/site-packages/mtools/mlaunch/mlaunch.py", line 1708, in _add_user
    **opts)
  File "/root/.local/lib/python3.6/site-packages/pymongo/database.py", line 1339, in add_user
    session=session, **kwargs)
  File "/root/.local/lib/python3.6/site-packages/pymongo/database.py", line 1253, in _create_or_update_user
    self.command(command_name, name, session=session, **opts)
  File "/root/.local/lib/python3.6/site-packages/pymongo/database.py", line 733, in command
    codec_options, session=session, **kwargs)
  File "/root/.local/lib/python3.6/site-packages/pymongo/database.py", line 630, in _command
    client=self.__client)
  File "/root/.local/lib/python3.6/site-packages/pymongo/pool.py", line 618, in command
    self._raise_connection_failure(error)
  File "/root/.local/lib/python3.6/site-packages/pymongo/pool.py", line 613, in command
    user_fields=user_fields)
  File "/root/.local/lib/python3.6/site-packages/pymongo/network.py", line 167, in command
    parse_write_concern_error=parse_write_concern_error)
  File "/root/.local/lib/python3.6/site-packages/pymongo/helpers.py", line 136, in _check_command_response
    raise NotMasterError(errmsg, response)
pymongo.errors.NotMasterError: not master
</pre>

Reproduce:

<pre>
./test.sh
</pre>

Does not happen every time, in fact failure rate is < 10%.
