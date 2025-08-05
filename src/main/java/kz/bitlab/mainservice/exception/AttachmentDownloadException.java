package kz.bitlab.mainservice.exception;

public class AttachmentDownloadException extends RuntimeException {

    public AttachmentDownloadException(String message) {
        super(message);
    }

    public AttachmentDownloadException(String message, Throwable cause) {
        super(message, cause);
    }
}
