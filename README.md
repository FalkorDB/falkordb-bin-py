# falkordb-bin

Platform-specific binary wheels for embedded FalkorDB usage in `falkordb-py`.

This package ships:
- `redis-server` (built from Redis source)
- `falkordb.so`/`falkordb.dylib` (downloaded from FalkorDB GitHub releases)

## Install

```bash
pip install falkordb-bin
```

## Python API

```python
import falkordb_bin

redis_server = falkordb_bin.get_redis_server()
module_path = falkordb_bin.get_falkordb_module()
```

## Release model

- Wheels are platform-specific and published from CI.
- `falkordb-bin` version should mirror `falkordb` version.
