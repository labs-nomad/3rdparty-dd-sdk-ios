## 3rdparty-dd-sdk-ios
#### Upgrade instructions
- Edit **build.sh** and look for the *GIT_REPO* and *GIT_TAG* settings near the top of the file. These strings control which tag and repository we are building. Update the *GIT_TAG* to the new version you want to build.
- Run **build.sh** and see if it works with the new code. If it doesn't, update the script to restore the build to working order.
- Upon success, the output binaries will go into the **bin** directory.