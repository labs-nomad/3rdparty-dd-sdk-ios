#!/bin/bash
set -e
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#----------------------------------------------------------------#
# configuration
#----------------------------------------------------------------#

GIT_REPO="git@github.com:DataDog/dd-sdk-ios.git"
GIT_TAG="2.24.0"

#----------------------------------------------------------------#
# import libraries
#----------------------------------------------------------------#

source "${CURRENT_DIR}/submodules/dev-ops/scripts/include/git.sh"
source "${CURRENT_DIR}/submodules/dev-ops/scripts/include/file.sh"
source "${CURRENT_DIR}/submodules/dev-ops/scripts/include/util.sh"
source "${CURRENT_DIR}/submodules/dev-ops/scripts/include/xcode.sh"

#----------------------------------------------------------------#
function buildDataDog {

    # check dependencies
    checkDependencies

    # settings
    local publishDir="${CURRENT_DIR}/bin"
    local workingDir="${CURRENT_DIR}/.working"
    
    # clean 
    file_safeRmDir          "${workingDir}"    
    file_affirmDirectory    "${workingDir}"

    file_safeRmDir          "${publishDir}"
    file_affirmDirectory    "${publishDir}"
    
    # get source
    local checkoutDir="${workingDir}/checkout"
    git_fetchSourceBranchOrTag "${GIT_REPO}" "${GIT_TAG}" "${checkoutDir}"

    # build
    local dataDogRootDir="${checkoutDir}/dd-sdk-ios"
    cd ${dataDogRootDir}

    # edit the built-in script so it produces static frameworks instead of dynamic
    printf "%s\n" "54i" "MACH_O_TYPE=staticlib \\" "." "w" "q" | ed -s "./tools/release/build-xcframeworks.sh"
   
    # run the built-in script
    ./tools/release/build-xcframeworks.sh   \
        --repo-path ${dataDogRootDir}       \
        --output-path ${publishDir}         \
        --ios
}

#----------------------------------------------------------------#
function checkDependencies {
    util_commandExists "xcbeautify" || (util_echoError "Please install xcbeautify! (brew install xcbeautify)" && exit 1)
}

#----------------------------------------------------------------#
# execute
#----------------------------------------------------------------#
buildDataDog
