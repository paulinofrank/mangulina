// Client-side only: processes an artist image with the native Canvas API
// before upload. Every accepted image (JPG/JPEG/PNG/WebP) is resized to
// exactly 300x300 and re-encoded as WebP so the original file is never
// stored in the artists-images bucket.

const ARTIST_IMAGE_SIZE = 300;
const ARTIST_IMAGE_WEBP_QUALITY = 0.9;

const ACCEPTED_IMAGE_MIME_TYPES = ["image/jpeg", "image/png", "image/webp"];
const ACCEPTED_IMAGE_EXTENSIONS = [".jpg", ".jpeg", ".png", ".webp"];

export function isAcceptedArtistImage(file: File): boolean {
  if (ACCEPTED_IMAGE_MIME_TYPES.includes(file.type)) {
    return true;
  }

  // Some platforms report an empty MIME type; fall back to the extension.
  if (!file.type) {
    const name = file.name.toLowerCase();
    return ACCEPTED_IMAGE_EXTENSIONS.some((extension) => name.endsWith(extension));
  }

  return false;
}

function loadImageElement(objectUrl: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const image = new Image();

    image.onload = () => resolve(image);
    image.onerror = () =>
      reject(new Error("The selected file could not be loaded as an image."));

    image.src = objectUrl;
  });
}

export async function resizeArtistImage(file: File): Promise<File> {
  if (!isAcceptedArtistImage(file)) {
    throw new Error("Please upload a JPG, JPEG, PNG, or WebP image file.");
  }

  const objectUrl = URL.createObjectURL(file);

  try {
    const image = await loadImageElement(objectUrl);

    // Already a 300x300 WebP: skip the canvas round-trip so the file is not
    // recompressed. The upload path controls the stored filename, so the
    // original File can be returned as-is.
    const isWebP =
      file.type === "image/webp" || file.name.toLowerCase().endsWith(".webp");

    if (
      isWebP &&
      image.naturalWidth === ARTIST_IMAGE_SIZE &&
      image.naturalHeight === ARTIST_IMAGE_SIZE
    ) {
      return file;
    }

    const canvas = document.createElement("canvas");
    canvas.width = ARTIST_IMAGE_SIZE;
    canvas.height = ARTIST_IMAGE_SIZE;

    const context = canvas.getContext("2d");

    if (!context) {
      throw new Error("Could not create a canvas context to process the image.");
    }

    context.drawImage(image, 0, 0, ARTIST_IMAGE_SIZE, ARTIST_IMAGE_SIZE);

    const blob = await new Promise<Blob>((resolve, reject) => {
      canvas.toBlob(
        (result) => {
          if (result) {
            resolve(result);
          } else {
            reject(new Error("The image could not be converted to WebP."));
          }
        },
        "image/webp",
        ARTIST_IMAGE_WEBP_QUALITY,
      );
    });

    return new File([blob], "artist.webp", { type: "image/webp" });
  } finally {
    URL.revokeObjectURL(objectUrl);
  }
}
