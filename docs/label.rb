require_relative '../lib/zebra/zpl'

if ARGV.count == 0
  puts "ID not supplied, exiting"
  exit
end

label = Zebra::Zpl::Label.new(
  width:        400,
  length:       239,
  print_speed:  3
)

qr_data = ARGV[0]

heading = Zebra::Zpl::Text.new(
  position: [210, 75],
  data: "GAISA SARGS",
  font_size: Zebra::Zpl::FontSize::SIZE_3
)

sub_heading = Zebra::Zpl::Text.new(
  position: [210, 115],
  data: qr_data,
  font_size: Zebra::Zpl::FontSize::SIZE_3
)

qrcode = Zebra::Zpl::Qrcode.new(
  data:             qr_data,
  position:         [16,23],
  scale_factor:     7,
  correction_level: 'H'
)

label << heading
label << sub_heading
label << qrcode

print_job = Zebra::PrintJob.new 'ZTC-GK420d'

ip = '192.168.88.127'  # can use 'localhost', '127.0.0.1', or '0.0.0.0' for local machine

print_job.print label, ip
