package io.github.wkktoria.pagenook.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HashGeneratorUtilTest {
    @Test
    void testHashString() {
        final String input = "mysecret";

        final String hashedMD5 = HashGeneratorUtil.generateMD5(input);

        assertEquals("06c219e5bc8378f3a8a3f83b4b7e4649", hashedMD5);
    }
}