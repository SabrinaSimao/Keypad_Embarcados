/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <system.h>
#include "sys/alt_irq.h"


void Keypad_init();
void Keypad_config(int adress, char enable, char clear, char reset, char irq);       // Configura o periférico
void Keypad_halt();          // Desativa o periférico
void Keypad_en_irq();        // Habilita interrupção
void Keypad_disable_irq();   // Desabilita interrupção
void Keypad_read_buffer(int adress, int *buffer);
//int Keypad_write_xxxxx();
static void Keypad_handler_irq();


void Keypad_clr(int adress);

uint32_t *p_key = (uint32_t *)KEYPAD_0_BASE;

void Keypad_init(int adress){
	uint32_t *p_key = (uint32_t *)adress;
	*(p_key+0) = 1<<31|0<<7|1<<15|0<<0;

	alt_irq_register( 3, NULL, Keypad_handler_irq);
}

static void Keypad_handler_irq(int adress){

	printf("ENTROU IRQ\n");
	Keypad_disable_irq(adress);


}

void Keypad_config(int adress, char enable, char clear, char reset, char irq){
	uint32_t *p_key = (uint32_t *)adress;
	*(p_key+0) = enable<<31|clear<<7|irq<<15|reset<<0;
}

void Keypad_halt(int adress){
	uint32_t *p_key = (uint32_t *)adress;
	*(p_key+0) = 0<<31|1<<7|0<<0;
}

void Keypad_read_buffer(int adress, int *buffer){
	uint32_t *p_key = (uint32_t *)adress;
	*buffer = *(p_key+1);
}

void Keypad_clr(int adress){
	*(p_key+0) = 1<<31|1<<7|0<<0;

}

void Keypad_en_irq(int adress){

	printf("Interrupcao Iniciada\n");
	uint32_t *p_key = (uint32_t *)adress;
	*(p_key+0) = 1<<15;

}

void Keypad_disable_irq(int adress){

	printf("Interrupcao Desligada\n");
	uint32_t *p_key = (uint32_t *)adress;
	*(p_key+0) = 0<<15;

}

int main(){

  printf("Hello from Nios II!\n");
  Keypad_en_irq(KEYPAD_0_BASE);
  Keypad_init(KEYPAD_0_BASE);

  printf("Keypad INIT\n");
  int key;
  while(1){

	  Keypad_read_buffer(KEYPAD_0_BASE, &key);

	  printf("Read: %04x \n", key);
	  //Keypad_clr(KEYPAD_0_BASE);
	  usleep(100000);

  }

  return 0;
}
