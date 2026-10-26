/* V1 time wraps at 32 bits; Linux supplies seconds and nanoseconds. */
__ticks(seconds,nanos) {
    return(((seconds-31536000)*60+nanos*60/1000000000)&4294967295);
}
