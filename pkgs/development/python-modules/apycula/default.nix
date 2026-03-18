{
  lib,
  buildPythonPackage,
  msgspec,
  numpy,
  fastcrc,
  fetchPypi,
  setuptools-scm,
}:

buildPythonPackage (finalAttrs: {
  pname = "apycula";
  version = "0.31";
  pyproject = true;

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-77pr4HbS2adFeEI3Q3KzcCfJMi4UomOtKnuGAxobxF0=";
  };

  build-system = [ setuptools-scm ];

  dependencies = [
    msgspec
    numpy
    fastcrc
  ];

  # Tests require a physical FPGA
  doCheck = false;

  pythonImportsCheck = [ "apycula" ];

  meta = {
    description = "Open Source tools for Gowin FPGAs";
    homepage = "https://github.com/YosysHQ/apicula";
    changelog = "https://github.com/YosysHQ/apicula/releases/tag/${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ newam ];
  };
})
