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

    # build frameworks
    local apolloRootDir="${checkoutDir}/apollo-ios"

    # buildApolloFramework                        \
    #     "Apollo"                                \
    #     "Apollo-Target-Framework.xcconfig"      \
    #     "${apolloRootDir}"                      \
    #     "${workingDir}"                         \
    #     "${publishDir}"
        
    # buildApolloFramework                        \
    #     "ApolloAPI"                             \
    #     "Apollo-Target-ApolloAPI.xcconfig"      \
    #     "${apolloRootDir}"                      \
    #     "${workingDir}"                         \
    #     "${publishDir}"
        
    # buildApolloFramework                        \
    #     "ApolloUtils"                           \
    #     "Apollo-Target-ApolloUtils.xcconfig"    \
    #     "${apolloRootDir}"                      \
    #     "${workingDir}"                         \
    #     "${publishDir}"
}

#----------------------------------------------------------------#
# execute
#----------------------------------------------------------------#
buildDataDog
