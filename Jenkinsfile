node("docker") {
  checkout scm

  stage("build") {
    // Create 'release_build' file, create 'build_tag' file. See build_name
    // for details. 
    sh "cd build && scripts/build_name"
    
    sh "cd build && ./build"
  }
}