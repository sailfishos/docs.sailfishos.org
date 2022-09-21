---
title: Known Issues
permalink: Support/Releases/Known_Issues/
parent: Releases
layout: default
nav_order: 100
---

The table below lists some significant known issues in Sailfish OS releases. The release notes (<a href="https://forum.sailfishos.org/tag/release-notes">kept in Sailfish OS Forum</a>) of upcoming OS releases (starting with 4.5.0) will point to this table, instead of listing the issues in the notes.

  <table width="100%">
    <thead>
        <tr>
           <th>Devices<br />affected</th>
           <th>Known issues</th>
           <th>Since<br />release</th>
           <th>Fixed<br />in release</th>
        </tr>
    </thead>
    <tbody>
        <tr>
          <td>All</td>
          <td>Bluetooth devices are not supported by Android App Support with the exception of speakers.</td>
          <td>All</td>
          <td></td>
        </tr>
        <tr>
          <td>All</td>
          <td>Flashing Sailfish X might fail (often caused by issues with USB ports). Please read <a href="https://jolla.zendesk.com/hc/en-us/articles/360012031854">this article</a>.</td>
          <td>All</td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia X, Jolla Tablet</td>
          <td>Manual Android app installation from the terminal or file managers is currently not working on the Android 4.4 version of Android App Support on Sailfish OS 4.4. To solve this, disable sandboxing for this handler by editing the file <code>/usr/share/applications/apkd-mime-handler.desktop</code> and adding the following to the end of the file:
<div markdown="1">

```ini
[X-Sailjail]
Disabled
```
</div>
          This doesn’t affect installing Android apps from the Jolla store, nor other Android stores.
          </td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Android App Support 10 on Xperia 10 II, 10 and XA2</td>
          <td>Sometimes, Android apps may not be able to use Internet connections via a mobile network. If there are connection problems later on (either WLAN or mobile data), stopping and starting the Android service at “Settings > Android App Support” should help. Toggling the connection off and on is another trick to try.</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 III</td>
          <td>3rd party caller may hear their own voice echo; use low volume, wired headphones, or loudspeaker as workaround</td>
          <td>4.4.0.64<br />Vanha Rauma</td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 III</td>
          <td>LED indicator colours have a visibly stronger green component</td>
          <td>4.4.0.64<br />Vanha Rauma</td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 III</td>
          <td>Sensors of tele and ultra wide camera lenses are disabled for now</td>
          <td>4.4.0.64<br />Vanha Rauma</td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 III</td>
          <td>FM radio is not supported</td>
          <td>4.4.0.64<br />Vanha Rauma</td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 II</td>
          <td>Features not implemented: Factory reset (use reflashing instead)</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia 10 II</td>
          <td>Top edge swipes in landscape orientation may not work very well</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 II</td>
          <td>The sidetone feature is not perfectly calibrated, and sidetone volume can be a bit high in wired accessories during voice calls</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10 II</td>
          <td>Mobile data does not work in 2G and 3G networks on SIM #2.</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia 10</td>
          <td>Features not implemented: FM radio, double-tap wakeup, support for dual camera, RTC Alarms.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia 10</td>
          <td>Rarely, audio playback and sensors (display rotation) may stop working. If this happens, please restart the device</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia 10</td>
          <td>In some cases, the acceptance of the PIN code of a SIM card may take up to 5…20 seconds</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia 10</td>
          <td>The phone may not turn off by applying the Power key or the Top Menu. A forced power down goes like this: press both the Volume Up and Power keys down. Keep them down for 20-30 sec until the vibrator plays 3 times - now release the keys</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia 10</td>
          <td>Transitions related to network switching 4G > 3G (call begins) and 3G > 4G (call ends) may take time on some networks. Getting the data connection via 4G back might require extra actions in the worst cases. Normally, in most networks, these transitions take a few seconds on Xperia 10.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia XA2</td>
          <td>Features not implemented: FM radio, double-tap wakeup, RTC Alarms (XA2 does not power up when alarm time has elapsed )</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia XA2</td>
          <td>Bluetooth: there may be problems in connecting to some peripheral devices</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia XA2</td>
          <td>With <a href="https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile">v17B Sony vendor image</a> we observed a decrease in the perceived signal strength of the 5 GHz WLAN access points (investigations ongoing). Version <a href="https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile-v16/">v16</a> works better in this respect. Therefore we would not recommend flashing v17B for the time being if you use WLAN networks in the 5 GHz band. You can reflash the vendor image of your choice by following the instructions <a href="https://jolla.zendesk.com/hc/en-us/articles/360019346354"> in here</a>.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia XA2</td>
          <td>Some XA2 devices suffer from the loss of audio during voice calls. Reported <a href="https://forum.sailfishos.org/t/3-4-0-22-xa2-phone-calls-no-audio/2446">here</a>.</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>Features not implemented: FM radio, double-tap wakeup, step counter, RTC Alarms</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>Issues with mobile data persist on some SIM cards. Turn the Flight mode on and off to reset the network setup. Reverting the device to Android and re-installing Sailfish X has often helped. See our <a href="https://jolla.zendesk.com/hc/en-us/articles/115004283713">support article</a>.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>Camera: force autofocus mode for photos, and continuous for video. After this, camera focus is still not ideal - as the camera stays out of focus when it starts until you either tap or you try to take a shot - but the pictures seem to be better focused now.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>Bluetooth: problems with some car equipment, some audio devices and computers may appear.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>The loudspeaker volume level cannot be adjusted very high.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>Not all SD cards are recognized and mounted.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Xperia X</td>
          <td>There is a green stripe on the lower edge of the Camera viewfinder. This does not prevent taking pictures, though.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Jolla Tablet</td>
          <td>There is no progress bar during the installation phase of OS upgrades. This makes it difficult to follow if it makes progress or not. However, if there are no problems the device will restart itself in the end - please wait patiently. If you feel that you have waited enough, wait for yet another 20 minutes before you turn off the device to allow some more time for it to complete the job. Interrupting too early may break the tablet.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Jolla Tablet</td>
          <td>Taking screenshots is broken. Pressing the VOL keys together seems to create an image but it cannot be viewed in Gallery.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Gemini PDA</td>
          <td>Features not implemented: double-tap wakeup, RTC Alarms</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Gemini PDA</td>
          <td>Gemini Screenshot Button Fn + X does not work</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Gemini PDA</td>
          <td>Not possible to answer calls when Gemini is closed with a side button</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Gemini PDA</td>
          <td>Horizontal screen in Gemini is not supported by all 3rd party apps.</td>
          <td></td>
          <td>Not planned</td>
        </tr>
        <tr>
          <td>Jolla C</td>
          <td>If there are issues with the camera of Jolla C, do the following:
<div markdown="1">

```nosh
/usr/bin/killall minimediaservice
```
</div>
          and then start the camera again.
          </td>
          <td></td>
          <td>Not planned</td>
        </tr>
      </tbody>
  </table>


