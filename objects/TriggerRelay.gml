#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Distributes signal to multiple instances. Allows setting locks, delays, counting and etc

delay=0
delay_passed=false
locked=false
locked_key=""
locked_behavior="consume" //"hold"
locked_trigger_asap=false
invert_signal=false
current_signal_is_off=false
count=0
inst0=noone
inst1=noone
inst2=noone
inst3=noone
inst4=noone
inst5=noone
inst6=noone
inst7=noone
inst8=noone
inst9=noone
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///set delay as passed once timer runs out
delay_passed=1
event_user(0)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field delay: number - 0
//field locked: false
    //field locked_key: string
    //field     locked_behavior: enum("consume", "hold") - "consume". If "consume" then makes any incoming signal be completely ignored while locked, "hold" will hold incoming signals until unlocked
//field count: number - 0. Will only send signal if was activated specified number of times before that
//field invert_signal: false - Sends "off" signal instead of "on", thus disabling most triggers
//field inst0: instance
//field inst1: instance
//field inst2: instance
//field inst3: instance
//field inst4: instance
//field inst5: instance
//field inst6: instance
//field inst7: instance
//field inst8: instance
//field inst9: instance
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Send signal to receivers
if delay>0 {
    alarm[0]=delay
    if delay_passed delay_passed=0
    else exit
}
if count>1 {
    count-=1
    exit
}
var trig; trig=ternary(current_signal_is_off^invert_signal,ev_trigger_off,ev_trigger_on)
with (inst0) event_trigger(trig)
with (inst1) event_trigger(trig)
with (inst2) event_trigger(trig)
with (inst3) event_trigger(trig)
with (inst4) event_trigger(trig)
with (inst5) event_trigger(trig)
with (inst6) event_trigger(trig)
with (inst7) event_trigger(trig)
with (inst8) event_trigger(trig)
with (inst9) event_trigger(trig)
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///When ON signal is recieved
if locked {
    if locked_behavior=="hold" locked_trigger_asap=1
    exit
}

event_user(0)
#define Trigger_Trigger Off
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///When OFF signal is recieved
if locked {
    if locked_behavior=="hold" locked_trigger_asap=1
    exit
}
current_signal_is_off=true
event_user(0)
current_signal_is_off=false
#define Trigger_Trigger Unlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///unlock yourself (whoever calls this did the key checks i hope)
if locked {
    locked = false
    if locked_behavior=="hold" and locked_trigger_asap {
        event_user(0)
    }
}
