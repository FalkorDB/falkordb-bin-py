from setuptools import setup
from wheel.bdist_wheel import bdist_wheel as _bdist_wheel


class bdist_wheel(_bdist_wheel):
    """Mark wheels as platform-specific because they bundle native binaries."""

    def finalize_options(self):
        super().finalize_options()
        self.root_is_pure = False

    def get_tag(self):
        python_tag, abi_tag, platform_tag = super().get_tag()
        if platform_tag.endswith("macosx_15_0_arm64") or platform_tag.endswith("macosx_14_0_arm64"):
            platform_tag = "macosx_11_0_arm64"
        return python_tag, abi_tag, platform_tag


setup(cmdclass={"bdist_wheel": bdist_wheel})
