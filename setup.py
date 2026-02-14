from setuptools import setup
from wheel.bdist_wheel import bdist_wheel as _bdist_wheel


class bdist_wheel(_bdist_wheel):
    """Mark wheels as platform-specific because they bundle native binaries."""

    def finalize_options(self):
        super().finalize_options()
        self.root_is_pure = False


setup(cmdclass={"bdist_wheel": bdist_wheel})

