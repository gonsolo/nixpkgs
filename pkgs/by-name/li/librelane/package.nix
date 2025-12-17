{
  lib,
  fetchFromGitHub,
  python3Packages,
  pdk-ciel,
  libparse-python,
}:

python3Packages.buildPythonApplication {
  pname = "librelane";
  # Update version to match your fork's metadata if necessary
  version = "2.4.9";

  pyproject = true;
  build-system = [ python3Packages.poetry-core ];

  src = fetchFromGitHub {
    owner = "gonsolo";
    repo = "librelane";
    # Use the specific commit hash or branch name where your fixes are
    rev = "gonsolo";
    # Replace with the actual hash. Use lib.fakeHash or "" to get the correct one from the error message.
    hash = "sha256-DubuzKUqzz9P+HECq58TGLZOMyWrSwxVd1+/OIpbDgM=";
    #hash = lib.fakeHash;
  };

  # Standard dependencies from your fork's pyproject.toml
  propagatedBuildInputs = with python3Packages; [
    pdk-ciel
    libparse-python
    numpy
    pandas
    click
    cloup
    deprecated
    httpx
    lxml
    psutil
    pyyaml
    rapidfuzz
    rich
    semver
    klayout
    yamlcore
  ];

  # Kept as per your original logic for assets not handled by the build system
  postInstall = ''
    site_packages=$out/${python3Packages.python.sitePackages}
    cp -r $src/librelane/scripts $site_packages/librelane/
    cp -r $src/librelane/examples $site_packages/librelane/
  '';
  # from above:
  #cp $src/librelane/pdk_hashes.yaml $site_packages/librelane/

  doCheck = false; # Set to true if you want to run the test suite during build

  meta = with lib; {
    description = "ASIC implementation flow infrastructure (Fork with Click fixes)";
    homepage = "https://github.com/gonsolo/librelane";
    license = licenses.asl20;
    maintainers = [ maintainers.gonsolo ];
    mainProgram = "librelane";
  };
}
