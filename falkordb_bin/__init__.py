import os
import sys
from pathlib import Path


def get_bin_dir() -> str:
    """Return path to the packaged binaries directory."""
    return str(Path(__file__).resolve().parent / "bin")


def get_redis_server() -> str:
    """Return full path to redis-server executable."""
    exe = "redis-server.exe" if sys.platform == "win32" else "redis-server"
    return os.path.join(get_bin_dir(), exe)


def get_falkordb_module() -> str:
    """Return full path to FalkorDB module library file."""
    if sys.platform == "darwin":
        module = "falkordb.dylib"
    elif sys.platform == "win32":
        module = "falkordb.dll"
    else:
        module = "falkordb.so"
    return os.path.join(get_bin_dir(), module)
