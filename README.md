# cordova-secure-device
When the plugin initializes it validates if the device is compromised by validating if it is rooted or jailbroken, and if a pin, passcode, or password is set. If the device is compromised the webview is removed and an alert message is shown. Upon closing the dialog the app exits.

The plugin does not expose any javascript interface, the validation is done when the plugin initializes.

## I18n
The plugin supports the following languages:
- English 
- Portuguese
- Spanish
- French
- German
- Japanese

# License
Copyright 2016 André Vieira

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.