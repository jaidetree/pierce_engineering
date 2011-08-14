module PhotoSystem
	require 'mini_magick'

	def self.upload( image )
		images = {}
		filename = Time.now.to_f.to_s.gsub('.','_') + '_' + image.original_filename
		photo = "#{Rails.root.to_s}/public/photos/#{filename}"
		FileUtils.copy(image.tempfile, photo )
		image = MiniMagick::Image.open( photo )	

		FileUtils.rm( photo )
		photo = photo.gsub /\..*$/, '' << ".jpg"

		image.format "jpg"
		image.write photo

		photo_url = photo.gsub /^.*\/photos/, '/photos' 

		images[:original] = photo_url
		images[:thumb] = generate_thumbnail photo, 'thumb', 150, true 
		images[:big] = generate_thumbnail photo, 'big', 600
		images[:med] = generate_thumbnail photo, 'med', 400
		images[:small] = generate_thumbnail photo, 'small', 50, true

		return images
	end

	def self.generate_thumbnail( file, label, width, crop = false )
		photo_name = file.gsub /\..*$/, '' << '_' << label << ".jpg"
		image = MiniMagick::Image.open( file )	

		w, h = image['%w %h'].split

		w = w.to_f
		h = h.to_f
		if ! crop

			h = (h*(width/w)).to_i
			w = width

			image.resize "#{w}x#{h}"

		else

			if w < h
				remove = (( h - w)/2).round
				image.shave("0x#{remove}")
			elsif w > h
				remove = ((w - h)/2).round
				image.shave("#{remove}x0")
			end

			image.resize("#{width}x#{width}")

		end


		image.write photo_name
		photo_url = photo_name.gsub /^.*\/photos/, '/photos' 

		return photo_url
	end

	def self.delete_photos( collection )
		if collection.class.name == "Hash"
			collection.each_pair do | label, file |

				full_file_path = "#{Rails.root.to_s}/public" << file

				if ! FileTest.exists? full_file_path
				   next 
				end

				FileUtils.rm full_file_path  

			end
		end
	end
end
