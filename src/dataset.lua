torch.setdefaulttensortype('torch.FloatTensor')
require 'torch'
require 'image'

function generate_dataset(images_directories, classId, channel, imgWidth, imgHeight)
--  assert(images_directories, "A parent path is needed to generate the dataset")

  local main_dataset = {}
  main_dataset.nbr_elements = 0

  table.sort(images_directories)

  for image_index, image_path in ipairs(images_directories) do
    local image_data = image.load(image_path)

    main_dataset.nbr_elements = main_dataset.nbr_elements + 1
    local label = torch.Tensor{classId}
    main_dataset[main_dataset.nbr_elements] = {image_data, label}

    if image_index % 50 == 0 then
      collectgarbage()
    end
  end

  -- Store everything as proper torch Tensor now that we know the total size
  local main_data = torch.Tensor(main_dataset.nbr_elements, channel, imgWidth, imgHeight)
  local main_label = torch.Tensor(main_dataset.nbr_elements, 1)
  for i,pair in ipairs(main_dataset) do
    main_data[i]:copy(main_dataset[i][1])
    main_label[i]:copy(main_dataset[i][2])
  end
  main_dataset = {}
  main_dataset.data = main_data
  main_dataset.label = main_label

  return main_dataset
end



-- These paths should not be changed
local rootPath = '/home/park/DBs/FAKE/livedet2009/rePark'
local identix = '/Identix'
local biometrika = '/Biometrika'
local crossmatch = '/CrossMatch'
local alive = '/Alive'
local gelatin = '/Gelatin'
local playdoh = '/PlayDoh'
local silcone = '/Silicone'
local zeroS = '/0s'
local twoS = '/2s'

local sensorFolder = rootPath .. identix
local aliveImgF =  sensorFolder .. alive
local gelatinImgF = sensorFolder .. gelatin
local pladohImgF = sensorFolder .. playdoh
local silconeImgF = sensorFolder .. silcone

-- Configure part -- 
local outputPath = sensorFolder .. '/' -- specify output folder
local zeroData = "identixSilicone2sData.bin" -- specify output name

local ext = 'png' -- specify file extension
local channel = 1 -- specify image channel
local imgWidth = 720 -- specify image width
local imgHeight = 720 -- specify image height
local classId = 3 -- specify class ID

local fileFolder = silconeImgF .. twoS
local imgFiles = {}



for file in paths.files(fileFolder) do
  if file:find(ext .. '$') then
    table.insert(imgFiles, paths.concat(fileFolder,file))
  end
end

local dataset = generate_dataset(imgFiles,0,channel,imgWidth,imgHeight)
torch.save(outputPath..zeroData, dataset)

print "Thank you for using"




---- Go over the file list:
--imgData = {}
--for i,file in ipairs(imgFiles) do
--   -- load each image
--   table.insert(imgData, image.load(file))
--end
--
--print('Loaded images:')
--print(imgData)

-- Display a of few them
--for i = 1,math.min(#imgFiles,10) do
--   image.display{image=imgData[i], legend=imgFiles[i]}
--end




