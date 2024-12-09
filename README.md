# <img src="https://github.com/user-attachments/assets/cbbf1370-acbc-4352-8521-3211cddb499a" style="display:inline" alt="HealthCheckerr App Logo" width="75" height="75"> *HealthCheckerr* 

*HealthCheckerr* is an iOS app for managing & monitoring Docker instances.

> Only on **iOS** and must be sideloaded or compiled via XCode.

## Navigation
- [Screenshots](#screenshots)
- [Features](#features)
- [Requirements](#requirements)
- [Compile IPA](#compile-ipa)
- [Get in touch](#get-in-touch)


# Screenshots
Monitor Containers         |Instances                  |Container Details          |Information                |
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
![ContainersView](https://github.com/user-attachments/assets/a49de15d-fcb4-45ba-80e8-f9bb129b13ef)  |  ![MainViewWithServers](https://github.com/user-attachments/assets/89e2366b-e26a-4e7f-85ce-a677d86c07d3)  |  ![ContainerDetails](https://github.com/user-attachments/assets/f34c83f1-1d9d-4b2a-ae0f-a0e6813a5955)  |  ![InfoAppInstructions](https://github.com/user-attachments/assets/3e3e8ad4-49fb-44cf-a983-b15d7ebdcf7e)  |  
More Info                  |Add Instance               |Remove Instance            |Initial View               |
![InfoDockerInstructions](https://github.com/user-attachments/assets/26303ac1-f785-417e-ac44-f8565595c86e)  |  ![AddInstance](https://github.com/user-attachments/assets/31f246ed-afec-47f6-9e99-379eb4fe27b5)  |  ![RemovingServer](https://github.com/user-attachments/assets/a71ef3e3-1cb8-4e5e-ab5a-433ecb21a1f9)  |  ![MainView](https://github.com/user-attachments/assets/a56e1cef-a19c-4400-a552-aafaf5fcbee4)

## Features

- View and monitor the health status of Docker containers.
- Start, stop, and restart containers directly from the app.
- Add and manage multiple Docker instances with unique IPs and nicknames.
- Securely route traffic through Tailscale for safe remote access.

## Requirements
> [!IMPORTANT]
> [Docker instance(s) must first be configured to accept HTTP API traffic.](https://gist.github.com/styblope/dc55e0ad2a9848f2cc3307d4819d819f "API Docker Instructions")

> [!NOTE]
> A non-jailbroken, non-Apple Developer user must re-sign a sideloaded app every 7 days.

> If you are unsure about sideloading here is a [Reddit Sideloading Guide by /u/CanResponsible7306](https://www.reddit.com/r/sideloaded/comments/1ak3x9t/how_to_sideload_application_on_ios_ipados/ "Reddit Sideload Guide")


# Compile IPA
> This is for non-Apple Developer users that want to compile an IPA themselves
1. Clone the Repository  
`git clone https://github.com/BraedenP232/HealthCheckerr.git`
3. Open the project in Xcode
4. In the menu bar, *Product -> Build*
5. Again in the menu bar, *Product -> Archive*
6. Right-Click Archived Build -> **Show in Finder**
7. Right-Click HealthCheckerrXXXXXX.xcarchive -> **Show Package Contents**
8. Copy the HealthCheckerr.app file from */Products/Applications/HealthCheckerr.app*
9. Make a folder anywhere specifically named **Payload** and paste the **HealthCheckerr.app** inside
10. Compress the **Payload** folder and rename it from **Payload.zip** to **HealthChecker.ipa**
11. Sideload using Trollstore or your favourite tool and enjoy!

# Get in touch  
*Find a bug? Want a feature added or changed? Make a pull-request or reach out to me directly!*  
### [Braeden Pelletier](https://www.braeden-pelletier.com/)
