---
title: Resistor values for JP2026 TOHs
permalink: Develop/Hardware/JP2601-TOH/Resistor_values/
parent: Jolla Phone TOH
layout: default
---

The possible resistor values and respective ID pin voltages are listed in the table below.

| Resistor value | Voltage | Reserved | Notes |
|----------------|---------|----------|-------|
| 560 ohm        | 0.1 V   | No       |       |
| 2 kohm         | 0.3 V   | No       |       |
| 3.9 kohm       | 0.5 V   | No       |       |
| 6.2 kohm       | 0.7 V   | Yes      |       |
| 10 kohm        | 0.9 V   | Yes      | The official Jolla TOHs use this. |
| 15 kohm        | 1.1 V   | Yes      |       |
| 27 kohm        | 1.3 V   | No       | 26k7 would be closer but this is a more common value. |
| 51 kohm        | 1.5 V   | No       | 49k9 would be closer but this is a more common value. |
| 160 kohm       | 1.7 V   | Yes      | Close to the disconnected voltage, please don't use. |

The voltage in the table is normative and in practice is within a few percent depending on the resistor and the device.
