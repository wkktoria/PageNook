package io.github.wkktoria.pagenook.util;

import io.github.wkktoria.pagenook.exception.HashGenerationException;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashGeneratorUtil {
    private HashGeneratorUtil() {
    }

    public static String generateMD5(final String input) {
        return hashString(input, "MD5");
    }

    private static String hashString(final String input, final String algorithm) {
        try {
            MessageDigest digest = MessageDigest.getInstance(algorithm);
            byte[] hashedBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));

            return convertByteArrayToHexString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new HashGenerationException("Could not generate hash from string", e);
        }
    }

    private static String convertByteArrayToHexString(final byte[] arrayBytes) {
        StringBuilder stringBuilder = new StringBuilder();

        for (byte arrayByte : arrayBytes) {
            stringBuilder.append(Integer.toString((arrayByte & 0xff) + 0x100, 16)
                    .substring(1));
        }

        return stringBuilder.toString();
    }
}
