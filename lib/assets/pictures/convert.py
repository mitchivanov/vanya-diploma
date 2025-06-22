import os
from PIL import Image

# Папка, где лежит скрипт и изображения
folder = os.path.dirname(os.path.abspath(__file__))

for filename in os.listdir(folder):
    if filename.lower().endswith((".jpg", ".jpeg")):
        file_path = os.path.join(folder, filename)
        img = Image.open(file_path)
        # Убираем расширение и добавляем .png
        new_filename = os.path.splitext(filename)[0] + ".png"
        new_file_path = os.path.join(folder, new_filename)
        img.save(new_file_path, "PNG")
        print(f"Converted {filename} -> {new_filename}")
