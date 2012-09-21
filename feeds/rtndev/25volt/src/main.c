/*
**  25volt - A lightweight tool for monitoring ups POWERCOM Imperial IMD-1025AP and maybe other for FreeBSD and Linux.
**  Copyright (C) 2009 Dmitry Schedrin <dmx@dmx.org.ru>
**
**  This program is free software; you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation; either version 2 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program; if not, write to the Free Software
**  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <usb.h>
#include <unistd.h>

#define HID_GET_REPORT 			0x01
#define HID_INPUT_REPORT 		0x01

#define HID_INTERFACE 			0x00
#define HID_CONFIGURATION 		0x00

#define IMD_VID 			0x0d9f
#define IMD_PID				0x00a2

#define USBRQ_HID_GET_REPORT    	0x01
#define USBRQ_HID_SET_REPORT    	0x09

#define USB_HID_REPORT_TYPE_FEATURE 	3

#define UPS_REPORT_VOLTAGE_IN 		29
#define UPS_REPORT_VOLTAGE_OUT		33
#define UPS_REPORT_FREQUENCY_IN		30
#define UPS_REPORT_FREQUENCY_OUT	34
#define UPS_REPORT_LOAD			31
#define UPS_REPORT_CAPACITY		24
#define UPS_REPORT_STATUS		20

#define CHARGING			1
#define DISCHARGING			(1 << 1)
#define ACPRESENT			(1 << 2)
#define BATTERYPRESENT			(1 << 3)
#define BELOWREMAININGCAPACITYLIMIT	(1 << 4)
#define REMAININGTIMELIMITEXPIRED 	(1 << 5)
#define NEEDREPLACEMENT			(1 << 6)
#define VOLTAGENOTREGULATED 		(1 << 7)
#define SHUTDOWNREQUESTED 		(1 << 8)
#define SHUTDOWNIMMINENT		(1 << 9)
#define COMMUNICATIONLOST		(1 << 10)
#define OVERLOAD			(1 << 11)

// Voltage in
// Voltage out
// Freq in
// Freq out
// battery
// load
// STATUS

//uint16_t voltage_in;
//uint16_t voltage_out;
//uint8_t frequency_in;
//uint8_t frequency_out;
uint16_t status;

char version[] ="1.0";

usb_dev_handle * usb_open_imd(void);
int tflag = 0, hflag = 0, ch;

unsigned char status_human_str[][30] = {
	"Charging:",
	"Discharging:",
	"AC present:",
	"Battery present:",
	"Below cap lim:",
	"Remain time exp:",
	"Need replace BAT:",
	"Voltage not regulated:",
	"Shutdown requested:",
	"Shutdown emitent:",
	"Communication lost:",
	"Overload:"
};

unsigned char status_str[][30] = {
	"charging:",
	"discharging:",
	"ac_present:",
	"battery_present:",
	"below_capacity_limit:",
	"remain_time_expired:",
	"need_replace_battery:",
	"voltage_not_regulated:",
	"shutdown_requested:",
	"shutdown_emitent:",
	"communication_lost:",
	"overload:"
};

usb_dev_handle* usb_open_imd(void) {

	struct usb_bus *bus;
	struct usb_device *dev;

	usb_find_busses();
	usb_find_devices();

	for (bus = usb_get_busses(); bus; bus = bus->next) {
		for (dev = bus->devices; dev; dev = dev->next) {
			if ((dev->descriptor.idVendor == IMD_VID)
			    && (dev->descriptor.idProduct == IMD_PID)) {
				return usb_open(dev);
			}
		}
	}
	return NULL;
}

void print_data(unsigned char *tmp, int ret) {

	int i;

	for (i=0; i<ret; i++) {
		printf("%.2x ", tmp[i]);
	}
	printf("\n");
}

uint16_t get_report16(usb_dev_handle *hdev, uint8_t report) {

	int16_t data;
	int ret;
	unsigned char tmp[1024];

	ret = usb_control_msg(hdev,  0xa1 , 0x01, (0x03 << 8) | report, 0, tmp, 1024, 5000);

	if (ret < 0) {
		printf("retrieving hid report failed\n");
		return -1;
	} else {
		#ifdef DEBUG
		printf("retrieving hid report succeeded, read %d bytes\n", ret);
		print_data(tmp, ret);
		#endif
		data = tmp[1];
		return data;
	}
}

uint8_t get_report8(usb_dev_handle *hdev, uint8_t report) {

	int8_t data;
	int ret;
	unsigned char tmp[1024];

	ret = usb_control_msg(hdev,  0xa1 , 0x01, (0x03 << 8) | report, 0, tmp, 1024, 5000);

	if (ret < 0) {
		printf("retrieving hid report failed\n");
		return -1;
	} else {
		#ifdef DEBUG
		printf("retrieving hid report succeeded, read %d bytes\n", ret);
		print_data(tmp, ret);
		#endif
		data = tmp[1];
		return data;
	}
}

uint8_t send_test(usb_dev_handle *hdev) {

	int8_t data;
	int ret;
	unsigned char tmp[2] = { 0x15, 0x01 };

	ret = usb_control_msg(hdev,  0x21 , 0x09, (0x03 << 8) | 0x15, 0, tmp, 2, 5000);

	if (ret < 0) {
		printf("retrieving hid report failed\n");
		return -1;
	} else {
		#ifdef DEBUG
		printf("retrieving hid report succeeded, read %d bytes\n", ret);
		print_data(tmp, ret);
		#endif
		data = tmp[1];
		return data;
	}
}

int main(int argc, char ** argv) {

	unsigned char tmp[1024];
	int i, ret, j;
	usb_dev_handle *hdev = NULL;
	unsigned char onoff[2][4] = {"off\0", "on\0"};

	while ((ch = getopt(argc, argv, "ht")) != -1) {
		switch (ch) {
			case 'h':
				hflag = 1;
				break;
			case 't':
				tflag = 1;
				break;
			case '?':
			default:
				printf("%s v.%s\n", argv[0], version);
				printf("%s [-h] [-t]\n", argv[0]);
				exit(1);
		}
	}

	//usb_set_debug(4);
	usb_init();

	if ((hdev = usb_open_imd()) == NULL) {
		printf("open failed\n");
		return 1;
	}


#ifdef LIBUSB_HAS_DETACH_KERNEL_DRIVER_NP
	if(usb_detach_kernel_driver_np(hdev, 0) < 0){
		; //fprintf(stderr, "Warning: could not detach kernel driver: %s\n", usb_strerror());
	}
#endif 

	ret = usb_control_msg(hdev, USB_ENDPOINT_IN | USB_TYPE_STANDARD |
			      USB_RECIP_INTERFACE, USB_REQ_GET_DESCRIPTOR,
			 (USB_DT_HID << 8), HID_INTERFACE, tmp, 1024, 5000);
	if (ret < 0)
		printf("retrieving hid descriptor failed\n");
	else {
		#ifdef DEBUG
		printf("retrieving hid descriptor succeeded, read %d bytes\n", ret);
		print_data(tmp, ret);
		#endif
	}

	//USB_TYPE_CLASS | USB_RECIP_DEVICE | USB_ENDPOINT_IN, USBRQ_HID_GET_REPORT,

	// 09 21 00 01 00 01 22 d0 02 
	
	if (tflag) {
		printf("Test: ");
		ret = send_test(hdev);
		if (ret < 0) {
			printf("Failed\n\n");
			return -1;
		} else {
			printf("OK\n\n");
			sleep(1);
		}
	}

	if (hflag) {

		printf("%-22s %d V\n", "Voltage in:", get_report16(hdev, UPS_REPORT_VOLTAGE_IN));
		printf("%-22s %d Hz\n", "Frequency in:", get_report8(hdev, UPS_REPORT_FREQUENCY_IN));
		printf("%-22s %d V\n", "Voltage out:", get_report16(hdev, UPS_REPORT_VOLTAGE_OUT));
		printf("%-22s %d Hz\n", "Frequency out:", get_report8(hdev, UPS_REPORT_FREQUENCY_OUT));
		printf("%-22s %d %%\n", "Load:", get_report8(hdev, UPS_REPORT_LOAD));
		printf("%-22s %d %%\n", "Capacity:", get_report8(hdev, UPS_REPORT_CAPACITY));

		printf("\n");

		status = get_report16(hdev, UPS_REPORT_STATUS);

		for (j=0; j<12; j++) {
			printf("%-22s %s\n", status_human_str[j], onoff[status & (1 << j) && 1]);
		}

	} else {
		
		printf("%s %d\n", "voltage_in:", get_report16(hdev, UPS_REPORT_VOLTAGE_IN));
		printf("%s %d\n", "frequency_in:", get_report8(hdev, UPS_REPORT_FREQUENCY_IN));
		printf("%s %d\n", "voltage_out:", get_report16(hdev, UPS_REPORT_VOLTAGE_OUT));
		printf("%s %d\n", "frequency_out:", get_report8(hdev, UPS_REPORT_FREQUENCY_OUT));
		printf("%s %d\n", "load:", get_report8(hdev, UPS_REPORT_LOAD));
		printf("%s %d\n", "capacity:", get_report8(hdev, UPS_REPORT_CAPACITY));
		
		status = get_report16(hdev, UPS_REPORT_STATUS);

		for (j=0; j<12; j++) {
			printf("%s %s\n", status_str[j], onoff[status & (1 << j) && 1]);
		}
	}

	if (usb_claim_interface(hdev, HID_INTERFACE) < 0) {
		usb_close(hdev);
		return 1;
	}

	for (i=0; i<0; i++) {
		ret = usb_interrupt_read(hdev, 0x81, tmp, 8, 500);

		if (ret < 0) {
			;
		} else {
			#ifdef DEBUG
			printf("interrupt read succeeded, read %d bytes\n", ret);
			print_data(tmp, ret);
			#endif
		}
	}

	if (usb_release_interface(hdev, HID_INTERFACE) < 0)
		printf("releasing interface failed\n");

	usb_close(hdev);

	return 0;
}
