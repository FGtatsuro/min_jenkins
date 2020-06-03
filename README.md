min_jenkins
===========

Minimum Jenkins environment.

Requirements
------------

The dependencies on other softwares/libraries for this service are as follows.

- [Docker](https://docs.docker.com/)
- [GNU Make](https://www.gnu.org/software/make/)

Usage
-----

1. Run a Jenkins container.

```bash
$ make start
```

2. Access Web UI.

```bash
$ open http://127.0.0.1:8080
```

3. Stop a Jenkins container.

```bash
$ make stop
```

Backup/Restore
--------------

1. Backup contents in Jenkins home directory.

```bash
$ make backup
```

2. Check whether step1's backup includes the contents you expect.

```bash
$ tar tzf jenkins_home_backup.tar.gz
```

3. Remove a volume including the contents.

```bash
$ make stop remove_volume
```

4. Restore the contents from backup.

```
$ make restore
```

5. Restart is needed for reloading restored contents.

```bash
$ make restart
```
