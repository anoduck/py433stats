# snr
Catalog and analyze transmissions from devices recorded in rtl_433 JSON logs



## Function
`snr` catalogs and characterizes ISM-band devices in your neighborhood using data from the JSON log file generated by `rtl_433`.  It processes rtl\_433 JSON log files to:

* read the packet information as recorded by rtl\_433 in a JSON log file,
* catalog all devices recorded in that log,
* count the packets and consolidate redundant packets into an individual transmission,
* summarize the statistics about packet signal-to-noise ratios (SNR) in the packets observed.

Sample output looks like this:

```
snr: Analyze rtl_433 json log files
Processing ISM 433MHz messages from file ../xaa.json

Processed 7045 de-duplicated records
Dated from Thu 2022-06-09 07:08:27 to Thu 2022-06-09 19:46:16

Device                      #Recs  Mean SNR ± 𝜎    Min    Max
Acurite-01185M 0                4    9.6 ±  4.9    6.4   16.9
Acurite-606TX 134             858    8.4 ±  2.1    5.5   20.0
Acurite-609TXC 194           1446   19.2 ±  0.5   12.4   21.2
Acurite-Tower 11524          2753   19.2 ±  0.5   13.2   20.8
Hyundai-VDO 60b87768            1   11.0 ±  0.0   11.0   11.0
Hyundai-VDO aeba4a98            1    7.2 ±  0.0    7.2    7.2
LaCrosse-TX141Bv3 253         348    8.2 ±  1.1    5.7   11.5
LaCrosse-TX141THBv2 168       840    9.6 ±  1.1    6.0   19.2
Markisol 0                     75   19.2 ±  0.9   12.3   20.2
Markisol 256                   20   19.3 ±  0.4   18.5   20.2
Prologue-TH 203               699   11.6 ±  1.3    7.2   19.5
```
## Use

Issue the command `snr -f <JSON filename>` to generate the report; `snr -h` shows the command-line options.

## Details

`rtl_433_stats` reads the JSON log file created by rtl\_433 (recommend to stop rtl_433 so that the JSON log file is closed for processing). The observed devices, as recorded in the JSON file in temporal order, are cataloged in alphabetical order in a summary table.  The summary includes a count of the number of packets and de-duplicated transmissions seen for that device and basic statistics for the signal-to-noise ratios:

* count of samples,
* mean,
* std deviation,
* min value seen, and
* max value seen.

JSON log times are expected to be in the format "HH:MM:SS", to the nearest second with no fractional part.

`snr` summarizes information only for the first packet in each transmission and ignores "duplicated" packets.  A packet is considered a duplicate of its predecessor if the concatenated device identifier string is repeated within 2 seconds of that predecessor.  Other recorded data (snr, etc.) are *not* compared, and for some devices that may not be desirable.  The algorithm only considers the immediate predecessor record in the JSON file, not the immediate predecessor record *for that device*, so interleaved data packets from differing devices would result in imperfect de-duplication in high-traffic regions.

## Installation

1. Connect to the `c-version` directory and `make` and then `make install`.  Note that this installs the *snr* executable into `~/bin`; edit `Makefile`'s definition of `BIN` if you want the code installed elsewhere, or simply execute the programs from the download directory rather than install.
2. Assuming that `~/bin/` is in your path or that you execute from the download directory, you may then process JSON log files.  For example, to process the `xaa.json` file that is distributed with the package, `snr -f ../xaa.json` and compare with the sample `xaa-output.prn` file distributed with the package to verify correct operation.

## Dependencies
This code uses Eric Raymond's mjson.c library to parse the rtl_433 JSON file and would not have been possible without it: that code is included in this distribution.  One slight modification to Raymond's distributed code was needed to accommodate model values that were sometimes numeric and sometimes quoted strings; that modification is noted in the mjson.c file included in this distribution.

## Author
David Todd, hdtodd@gmail.com, 2022.05.  Updated 2023.04.
