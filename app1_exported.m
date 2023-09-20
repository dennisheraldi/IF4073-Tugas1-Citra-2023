classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        TabGroup                       matlab.ui.container.TabGroup
        HistogramTab                   matlab.ui.container.Tab
        PreviewCitraMasukanLabel       matlab.ui.control.Label
        PathInfoLabel                  matlab.ui.control.Label
        PathcitraLabel                 matlab.ui.control.Label
        TampilkanHistogramButton       matlab.ui.control.Button
        PilihFileCitraButton           matlab.ui.control.Button
        CitramasukanLabel              matlab.ui.control.Label
        ImageAxes                      matlab.ui.control.UIAxes
        PerbaikanKualitasTab           matlab.ui.container.Tab
        PereganganKontrasPanel         matlab.ui.container.Panel
        ProsesPereganganKontrasButton  matlab.ui.control.Button
        TransformasiPangkatPanel       matlab.ui.container.Panel
        ProsesTransformasiPangkatButton  matlab.ui.control.Button
        ParameterLabel_3               matlab.ui.control.Label
        gammaSpinner                   matlab.ui.control.Spinner
        Label                          matlab.ui.control.Label
        cSpinner_2                     matlab.ui.control.Spinner
        cSpinner_2Label                matlab.ui.control.Label
        TransformasiLogPanel           matlab.ui.container.Panel
        ProsesTransformasiLogButton    matlab.ui.control.Button
        ParameterLabel_2               matlab.ui.control.Label
        cSpinner                       matlab.ui.control.Spinner
        cSpinnerLabel                  matlab.ui.control.Label
        PembalikanCitraPanel           matlab.ui.container.Panel
        ProsesBalikanCitraButton       matlab.ui.control.Button
        PencerahanCitraPanel           matlab.ui.container.Panel
        ProsesPencerahanCitraButton    matlab.ui.control.Button
        ParameterLabel                 matlab.ui.control.Label
        bSpinner                       matlab.ui.control.Spinner
        bSpinnerLabel                  matlab.ui.control.Label
        aSpinner                       matlab.ui.control.Spinner
        aSpinnerLabel                  matlab.ui.control.Label
        PreviewCitraMasukanLabel_2     matlab.ui.control.Label
        PathInfoLabel_2                matlab.ui.control.Label
        PathcitraLabel_2               matlab.ui.control.Label
        PilihFileCitraButton_2         matlab.ui.control.Button
        CitramasukanLabel_2            matlab.ui.control.Label
        ImageAxes_2                    matlab.ui.control.UIAxes
        PerataanHistogramTab           matlab.ui.container.Tab
        PreviewCitraMasukanLabel_3     matlab.ui.control.Label
        PathInfoLabel_3                matlab.ui.control.Label
        PathcitraLabel_3               matlab.ui.control.Label
        TampilkanHasilButton           matlab.ui.control.Button
        PilihFileCitraButton_3         matlab.ui.control.Button
        CitramasukanLabel_3            matlab.ui.control.Label
        ImageAxes_3                    matlab.ui.control.UIAxes
        HistogramSpecificationTab      matlab.ui.container.Tab
        PathInfoLabel_5                matlab.ui.control.Label
        PathcitraacuanLabel            matlab.ui.control.Label
        PilihFileAcuanButton           matlab.ui.control.Button
        CitraacuanLabel                matlab.ui.control.Label
        PreviewCitraAcuanLabel         matlab.ui.control.Label
        PreviewCitraMasukanLabel_4     matlab.ui.control.Label
        PathInfoLabel_4                matlab.ui.control.Label
        PathcitraLabel_4               matlab.ui.control.Label
        TampilkanHasilButton_2         matlab.ui.control.Button
        PilihFileCitraButton_4         matlab.ui.control.Button
        CitramasukanLabel_4            matlab.ui.control.Label
        ImageAxes_5                    matlab.ui.control.UIAxes
        ImageAxes_4                    matlab.ui.control.UIAxes
    end

    
    methods (Access = public)

        function [resultGray, resultR, resultG, resultB] = getimagehistogram(~, img)
            % Menghitung histogram
            if size(img, 3) == 1
                % Citra Grayscale
                histValues = zeros(1, 256);
                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        intensity = img(i, j) + 1;
                        histValues(intensity) = histValues(intensity) + 1;
                    end
                end

                resultGray = histValues;
                resultR = 0;
                resultG = 0;
                resultB = 0;

            else
               % Citra Berwarna
                histValuesR = zeros(1, 256);
                histValuesG = zeros(1, 256);
                histValuesB = zeros(1, 256);
                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        intensityR = img(i, j, 1) + 1;
                        intensityG = img(i, j, 2) + 1;
                        intensityB = img(i, j, 3) + 1;
                        histValuesR(intensityR) = histValuesR(intensityR) + 1;
                        histValuesG(intensityG) = histValuesG(intensityG) + 1;
                        histValuesB(intensityB) = histValuesB(intensityB) + 1;
                    end
                end

                resultGray = 0;
                resultR = histValuesR;
                resultG = histValuesG;
                resultB = histValuesB;

            end
        end

        function imagehistogram(app,img,name)
            if size(img, 3) == 1
                [histValues, ~, ~, ~] = app.getimagehistogram(img);

                % Menampilkan histogram Grayscale dalam jendela popup
                figure('Name', ['Histogram Citra Grayscale dari',' ', name], 'NumberTitle', 'off');
                bar(histValues);
                xlabel('Derajat Keabuan');
                ylabel('Frekuensi');

            else
                [~, histValuesR, histValuesG, histValuesB] = app.getimagehistogram(img);

                % Menampilkan histogram Citra Berwarna
                figure('Name', ['Histogram Citra Berwarna dari',' ', name], 'NumberTitle', 'off');
                subplot(3, 1, 1);
                bar(histValuesR, 'r');
                title('Histogram Red');
                xlabel('Derajat Keabuan');
                ylabel('Frekuensi');
                subplot(3, 1, 2);
                bar(histValuesG, 'g');
                title('Histogram Green');
                xlabel('Derajat Keabuan');
                ylabel('Frekuensi');
                subplot(3, 1, 3);
                bar(histValuesB, 'b');
                title('Histogram Blue');
                xlabel('Derajat Keabuan');
                ylabel('Frekuensi');
            end
        end

        function [result, histRataGray, histRataR, histRataG, histRataB] = perataanhistogram(app,img)
            newimage = uint8(zeros(size(img, 1), size(img, 2)));
            totalpixel = (size(img, 1) * size(img, 2));
            if size(img, 3) == 1
                [histGray, ~, ~, ~] = app.getimagehistogram(img);

                histEqGray = zeros(1, 256);
                sum = 0.0;
                for i = 1:256
                    sum = sum + histGray(i);
                    prob = sum / totalpixel;
                    histEqGray(i) = round(255 * prob);
                end

                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        newimage(i,j) = histEqGray(img(i,j)+1);
                    end
                end

                histRataGray = histEqGray;
                histRataR = 0;
                histRataG = 0;
                histRataB = 0;
            else
                [~, histR, histG, histB] = app.getimagehistogram(img);

                histEqR = zeros(1, 256);
                histEqG = zeros(1, 256);
                histEqB = zeros(1, 256);
                sumR = 0.0;
                sumG = 0.0;
                sumB = 0.0;
                for i = 1:256
                    sumR = sumR + histR(i);
                    sumG = sumG + histG(i);
                    sumB = sumB + histB(i);
                    probR = sumR / totalpixel;
                    probG = sumG / totalpixel;
                    probB = sumB / totalpixel;
                    histEqR(i) = round(255 * probR);
                    histEqG(i) = round(255 * probG);
                    histEqB(i) = round(255 * probB);
                end

                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        newimage(i, j, 1) = histEqR(img(i, j, 1) + 1);
                        newimage(i, j, 2) = histEqR(img(i, j, 2) + 1);
                        newimage(i, j, 3) = histEqR(img(i, j, 3) + 1);
                    end
                end

                histRataGray = 0;
                histRataR = histEqR;
                histRataG = histEqG;
                histRataB = histEqB;
            end
            result = newimage;
        end

        function perbandinganduacitra(app, fig_title, img1, img2)
            figure("Name", fig_title,'NumberTitle', 'off')
            if (size(img1,1) >= size(img1,2))
                subplot(1,2,1); 
            else 
                subplot(2,1,1);
            end
            imshow(img1);
            title('Citra Masukan')
            
            if (size(img1,1) >= size(img1,2))
                subplot(1,2,2); 
            else 
                subplot(2,1,2);
            end
            imshow(img2);
            title('Citra Hasil');
            
            % Menampilkan histogram pada masing-masing citra
            app.imagehistogram(img1, 'Citra Masukan');
            app.imagehistogram(img2, 'Citra Hasil');
        end

        function result = spesifikasihistogram(app,img,imgacuan)
            newimage = uint8(zeros(size(img, 1), size(img, 2)));

            % Pemisahan antara gambar grayscale dan berwarna
            if size(img, 3) == 1
                % Mengambil histogram yang sudah diratakan untuk grayscale
                [~, hist, ~, ~, ~] = perataanhistogram(app, img);
                [~, histAcuan, ~, ~, ~] = perataanhistogram(app, imgacuan);
                histRes = zeros(1, 256);

                % Melakukan transformasi pada image input
                for i = 1:256
                    minval = abs(hist(i) - histAcuan(1));
                    minj = 0;
                    for j = 1:256
                        if abs(hist(i) - histAcuan(j)) < minval
                            minval = abs(hist(i) - histAcuan(j));
                            minj = j;
                        end
                    end
                    histRes(i) = minj;
                end

                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        newimage(i,j) = histRes(img(i,j)+1);
                    end
                end
            else
                % Mengambil histogram yang sudah diratakan untuk image
                % berwarna
                [~, ~, histR, histG, histB] = perataanhistogram(app, img);
                [~, ~, histAcuanR, histAcuanG, histAcuanB] = perataanhistogram(app, imgacuan);
                histResR = zeros(1, 256);
                histResG = zeros(1, 256);
                histResB = zeros(1, 256);

                % Melakukan transformasi pada image input
                for i = 1:256
                    doneR = false;
                    doneG = false;
                    doneB = false;
                    for j = 1:256
                        if histR(i) < histAcuanR(j) & ~doneR
                            histResR(i) = j;
                            doneR = true;
                        end
                        if histG(i) < histAcuanG(j) & ~doneG
                            histResG(i) = j;
                            doneG = true;
                        end
                        if histB(i) < histAcuanB(j) & ~doneB
                            histResB(i) = j;
                            doneB = true;
                        end
                        if doneR & doneG & doneB
                            break;
                        end
                    end
                end

                % Mentransformasi hasil spesifikasi histogram pada gambar
                for i = 1:size(img, 1)
                    for j = 1:size(img, 2)
                        newimage(i, j, 1) = histResR(img(i, j, 1) + 1);
                        newimage(i, j, 2) = histResG(img(i, j, 2) + 1);
                        newimage(i, j, 3) = histResB(img(i, j, 3) + 1);
                    end
                end
            end
            result = newimage;
        end

        function results = pencerahancitra(~,img, a, b)
            % Pencerahan citra
            % Input:
            %   - img: Citra asli (dalam tipe data apapun)
            %   - a: Konstanta pengali
            %   - b: Konstanta penjumlah 
            % Output:
            %   - results: Citra hasil pencerahan dalam tipe data uint8
            if ~isa(img, 'double')
                img = im2double(img);
            end
            results = (a*img)+(b/255);
            results = uint8(255*results);
        end

        function results = pembalikancitra(~,img)
            % Pembalikan citra
            % Input:
            %   - img: Citra asli (dalam tipe data apapun)
            % Output:
            %   - results: Citra hasil balikan
            results = 255 - img;
        end
        
        function results = transformasilog(~,img,c)
            % Transformasi log pada citra
            % Input:
            %   - img: Citra asli (dalam tipe data apapun)
            %   - c: Konstanta transformasi
            % Output:
            %   - results: Citra hasil transformasi dalam tipe data uint8
            if ~isa(img, 'double')
                img = im2double(img);
            end
            results = c*log(img+1);
            results = uint8(255*results);
        end

        function results = transformasipangkat(~,img,c,gamma)
            % Transformasi pangkat pada citra
            % Input:
            %   - img: Citra asli (dalam tipe data apapun)
            %   - c: Konstanta positif transformasi
            %   - gamma: Konstanta positif pangkat transformasi
            % Output:
            %   - results: Citra hasil transformasi dalam tipe data uint8
            if ~isa(img, 'double')
                img = im2double(img);
            end
            results = c*(img.^gamma);
            results = uint8(255*results);
        end
        
        function results = peregangankontras(~,img)
        % Peregangan kontras pada citra
        % Input:
        %   - img: Citra asli (dalam tipe data apapun)
        % Output:
        %   - results: Citra hasil peregangan dalam tipe data uint8
        
        % Inisiasi rmax dan rmin
        rmax = max(img, [], [1, 2]);
        rmin = min(img, [], [1, 2]);
        
        % Menghitung citra hasil
        results = (img - rmin) .* (255/(rmax - rmin));
        end

    end
   
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PilihFileCitraButton
        function PilihFileCitraButtonPushed(app, event)
            % Memilih gambar
            [fileName, pathName] = uigetfile({'*.png; *.jpg; *.jpeg; *.bmp; *.tif;', 'All Image Files'});
            fullPath = fullfile(pathName, fileName);

            if fileName ~= 0
                % Menampilkan path file di label
                app.PathInfoLabel.Text = fullPath;

                % Menampilkan citra di axes
                imshow(fullPath, 'Parent', app.ImageAxes);

                % Mengaktifkan tombol Tampilkan Histogram jika gambar dipilih
                app.TampilkanHistogramButton.Enable = 'on';
            end
        end

        % Button pushed function: TampilkanHistogramButton
        function TampilkanHistogramButtonPushed(app, event)
            % Memeriksa apakah ada gambar yang dipilih
            if isempty(app.PathInfoLabel.Text)
                msgbox('Pilih terlebih dahulu gambar sebelum menampilkan histogram.', 'Peringatan', 'warn');
                return; % Keluar dari callback jika tidak ada gambar yang dipilih
            end
            
            % Mendapatkan citra dari path
            img = imread(app.PathInfoLabel.Text);
            app.imagehistogram(img, 'Citra Masukan');

            
        end

        % Button pushed function: PilihFileCitraButton_2
        function PilihFileCitraButton_2Pushed(app, event)
            % Memilih gambar
            [fileName, pathName] = uigetfile({'*.png; *.jpg; *.jpeg; *.bmp; *.tif;', 'All Image Files'});
            fullPath = fullfile(pathName, fileName);

            if fileName ~= 0
                % Menampilkan path file di label
                app.PathInfoLabel_2.Text = fullPath;

                % Menampilkan citra di axes
                imshow(fullPath, 'Parent', app.ImageAxes_2);

                % Mengaktifkan tombol jika gambar dipilih
                app.ProsesPencerahanCitraButton.Enable = 'on';
                app.ProsesBalikanCitraButton.Enable = 'on';
                app.ProsesTransformasiLogButton.Enable = 'on';
                app.ProsesTransformasiPangkatButton.Enable = 'on';
                app.ProsesPereganganKontrasButton.Enable = 'on';
                app.aSpinner.Enable = 'on';
                app.bSpinner.Enable = 'on';
                app.cSpinner.Enable = 'on';
                app.cSpinner_2.Enable = 'on';
                app.gammaSpinner.Enable = 'on';

            end
        end

        % Button pushed function: ProsesPencerahanCitraButton
        function ProsesPencerahanCitraButtonPushed(app, event)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            a = app.aSpinner.Value;
            b = app.bSpinner.Value;
            result = app.pencerahancitra(img, a, b);
            
            % Menampilkan perbandingan citra asli dan hasil pencerahan
            app.perbandinganduacitra('Perbandingan Hasil Pencerahan Citra', img, result);

        end

        % Button pushed function: ProsesBalikanCitraButton
        function ProsesBalikanCitraButtonPushed(app, event)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            result = app.pembalikancitra(img);

            % Menampilkan perbandingan citra asli dan hasil balikan
            app.perbandinganduacitra('Perbandingan Hasil Pembalikan Citra', img, result);
        end

        % Button pushed function: ProsesTransformasiLogButton
        function ProsesTransformasiLogButtonPushed(app, event)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            c = app.cSpinner.Value;
            result = app.transformasilog(img,c);

            % Menampilkan perbandingan citra asli dan hasil transformasi
            app.perbandinganduacitra('Perbandingan Hasil Transformasi Log Citra', img, result);
        end

        % Button pushed function: ProsesTransformasiPangkatButton
        function ProsesTransformasiPangkatButtonPushed(app, event)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            c = app.cSpinner_2.Value;
            gamma = app.gammaSpinner.Value;
            result = app.transformasipangkat(img,c,gamma);

            % Menampilkan perbandingan citra asli dan hasil transformasi
            app.perbandinganduacitra('Perbandingan Hasil Transformasi Pangkat Citra', img, result);
        end

        % Button pushed function: ProsesPereganganKontrasButton
        function ProsesPereganganKontrasButtonPushed(app, event)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            result = app.peregangankontras(img);

            % Menampilkan perbandingan citra asli dan hasil transformasi
            app.perbandinganduacitra('Perbandingan Hasil Peregangan Kontras', img, result);
        end

        % Button pushed function: TampilkanHasilButton
        function TampilkanHasilButtonPushed(app, event)
            % Memeriksa apakah ada gambar yang dipilih
            if isempty(app.PathInfoLabel_3.Text)
                msgbox('Pilih terlebih dahulu gambar sebelum menampilkan histogram.', 'Peringatan', 'warn');
                return; % Keluar dari callback jika tidak ada gambar yang dipilih
            end
            
            % Mendapatkan citra dari path
            img = imread(app.PathInfoLabel_3.Text);

            % Menampilkan necessary output
            [newimage, ~, ~, ~, ~] = app.perataanhistogram(img);

            figure('Name', 'Citra Hasil Perataan', 'NumberTitle', 'off'); imshow(newimage);
            figure('Name', 'Citra Input', 'NumberTitle', 'off'); imshow(img);
            app.imagehistogram(newimage, 'Citra Hasil Perataan');
            app.imagehistogram(img, 'Citra Input');
        end

        % Button pushed function: PilihFileCitraButton_3
        function PilihFileCitraButton_3Pushed(app, event)
            % Memilih gambar
            [fileName, pathName] = uigetfile({'*.png; *.jpg; *.jpeg; *.bmp; *.tif;', 'All Image Files'});
            fullPath = fullfile(pathName, fileName);

            if fileName ~= 0
                % Menampilkan path file di label
                app.PathInfoLabel_3.Text = fullPath;

                % Menampilkan citra di axes
                imshow(fullPath, 'Parent', app.ImageAxes_3);

                % Mengaktifkan tombol Tampilkan Histogram jika gambar dipilih
                app.TampilkanHasilButton.Enable = 'on';
            end
        end

        % Button pushed function: PilihFileCitraButton_4
        function PilihFileCitraButton_4Pushed(app, event)
             % Memilih gambar
            [fileName, pathName] = uigetfile({'*.png; *.jpg; *.jpeg; *.bmp; *.tif;', 'All Image Files'});
            fullPath = fullfile(pathName, fileName);

            if fileName ~= 0
                % Menampilkan path file di label
                app.PathInfoLabel_4.Text = fullPath;

                % Menampilkan citra di axes
                imshow(fullPath, 'Parent', app.ImageAxes_4);

                % Mengaktifkan tombol Tampilkan Histogram jika gambar dipilih
                if ~isempty(app.PathInfoLabel_5.Text)
                    app.TampilkanHasilButton.Enable = 'on';
                end
            end
        end

        % Button pushed function: PilihFileAcuanButton
        function PilihFileAcuanButtonPushed(app, event)
             % Memilih gambar
            [fileName, pathName] = uigetfile({'*.png; *.jpg; *.jpeg; *.bmp; *.tif;', 'All Image Files'});
            fullPath = fullfile(pathName, fileName);

            if fileName ~= 0
                % Menampilkan path file di label
                app.PathInfoLabel_5.Text = fullPath;

                % Menampilkan citra di axes
                imshow(fullPath, 'Parent', app.ImageAxes_5);

                % Mengaktifkan tombol Tampilkan Histogram jika gambar dipilih
                if ~isempty(app.PathInfoLabel_4.Text)
                    app.TampilkanHasilButton_2.Enable = 'on';
                end
            end
        end

        % Button pushed function: TampilkanHasilButton_2
        function TampilkanHasilButton_2Pushed(app, event)
            img = imread(app.PathInfoLabel_4.Text);
            imgacuan = imread(app.PathInfoLabel_5.Text);
            
            % Pengecekan tipe gambar dan ukuran
            if size(img, 3) ~= size(imgacuan, 3)
                msgbox('Tipe gambar haruslah sama.', 'Peringatan', 'warn');
                return;
            end

            result = app.spesifikasihistogram(img, imgacuan);

            figure('Name', 'Citra Hasil Spesifikasi', 'NumberTitle', 'off'); imshow(result);
            figure('Name', 'Citra Input', 'NumberTitle', 'off'); imshow(img);
            figure('Name', 'Citra Acuan', 'NumberTitle', 'off'); imshow(imgacuan);
            app.imagehistogram(result, 'Citra Hasil Spesifikasi');
            app.imagehistogram(img, 'Citra Input');
            app.imagehistogram(imgacuan, 'Citra Acuan');
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9412 0.9412 0.9412];
            app.UIFigure.Position = [100 100 740 602];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [2 1 739 602];

            % Create HistogramTab
            app.HistogramTab = uitab(app.TabGroup);
            app.HistogramTab.Title = 'Histogram';

            % Create ImageAxes
            app.ImageAxes = uiaxes(app.HistogramTab);
            app.ImageAxes.XTick = [];
            app.ImageAxes.YTick = [];
            app.ImageAxes.Position = [42 22 649 423];

            % Create CitramasukanLabel
            app.CitramasukanLabel = uilabel(app.HistogramTab);
            app.CitramasukanLabel.Position = [41 531 86 22];
            app.CitramasukanLabel.Text = 'Citra masukan:';

            % Create PilihFileCitraButton
            app.PilihFileCitraButton = uibutton(app.HistogramTab, 'push');
            app.PilihFileCitraButton.ButtonPushedFcn = createCallbackFcn(app, @PilihFileCitraButtonPushed, true);
            app.PilihFileCitraButton.Position = [133 531 100 23];
            app.PilihFileCitraButton.Text = 'Pilih File Citra';

            % Create TampilkanHistogramButton
            app.TampilkanHistogramButton = uibutton(app.HistogramTab, 'push');
            app.TampilkanHistogramButton.ButtonPushedFcn = createCallbackFcn(app, @TampilkanHistogramButtonPushed, true);
            app.TampilkanHistogramButton.Enable = 'off';
            app.TampilkanHistogramButton.Position = [531 531 127 23];
            app.TampilkanHistogramButton.Text = 'Tampilkan Histogram';

            % Create PathcitraLabel
            app.PathcitraLabel = uilabel(app.HistogramTab);
            app.PathcitraLabel.Position = [41 502 59 22];
            app.PathcitraLabel.Text = 'Path citra:';

            % Create PathInfoLabel
            app.PathInfoLabel = uilabel(app.HistogramTab);
            app.PathInfoLabel.Position = [111 502 441 22];
            app.PathInfoLabel.Text = '';

            % Create PreviewCitraMasukanLabel
            app.PreviewCitraMasukanLabel = uilabel(app.HistogramTab);
            app.PreviewCitraMasukanLabel.Position = [306 456 128 22];
            app.PreviewCitraMasukanLabel.Text = 'Preview Citra Masukan';

            % Create PerbaikanKualitasTab
            app.PerbaikanKualitasTab = uitab(app.TabGroup);
            app.PerbaikanKualitasTab.Title = 'Perbaikan Kualitas';

            % Create ImageAxes_2
            app.ImageAxes_2 = uiaxes(app.PerbaikanKualitasTab);
            app.ImageAxes_2.XTick = [];
            app.ImageAxes_2.YTick = [];
            app.ImageAxes_2.Position = [254 185 437 289];

            % Create CitramasukanLabel_2
            app.CitramasukanLabel_2 = uilabel(app.PerbaikanKualitasTab);
            app.CitramasukanLabel_2.Position = [41 531 86 22];
            app.CitramasukanLabel_2.Text = 'Citra masukan:';

            % Create PilihFileCitraButton_2
            app.PilihFileCitraButton_2 = uibutton(app.PerbaikanKualitasTab, 'push');
            app.PilihFileCitraButton_2.ButtonPushedFcn = createCallbackFcn(app, @PilihFileCitraButton_2Pushed, true);
            app.PilihFileCitraButton_2.Position = [133 531 100 23];
            app.PilihFileCitraButton_2.Text = 'Pilih File Citra';

            % Create PathcitraLabel_2
            app.PathcitraLabel_2 = uilabel(app.PerbaikanKualitasTab);
            app.PathcitraLabel_2.Position = [41 502 59 22];
            app.PathcitraLabel_2.Text = 'Path citra:';

            % Create PathInfoLabel_2
            app.PathInfoLabel_2 = uilabel(app.PerbaikanKualitasTab);
            app.PathInfoLabel_2.Position = [111 502 441 22];
            app.PathInfoLabel_2.Text = '';

            % Create PreviewCitraMasukanLabel_2
            app.PreviewCitraMasukanLabel_2 = uilabel(app.PerbaikanKualitasTab);
            app.PreviewCitraMasukanLabel_2.FontName = 'Arial';
            app.PreviewCitraMasukanLabel_2.Position = [409 481 128 22];
            app.PreviewCitraMasukanLabel_2.Text = 'Preview Citra Masukan';

            % Create PencerahanCitraPanel
            app.PencerahanCitraPanel = uipanel(app.PerbaikanKualitasTab);
            app.PencerahanCitraPanel.Title = 'Pencerahan Citra';
            app.PencerahanCitraPanel.Position = [41 313 192 161];

            % Create aSpinnerLabel
            app.aSpinnerLabel = uilabel(app.PencerahanCitraPanel);
            app.aSpinnerLabel.HorizontalAlignment = 'right';
            app.aSpinnerLabel.Position = [13 79 25 22];
            app.aSpinnerLabel.Text = 'a';

            % Create aSpinner
            app.aSpinner = uispinner(app.PencerahanCitraPanel);
            app.aSpinner.Step = 0.1;
            app.aSpinner.Enable = 'off';
            app.aSpinner.Position = [53 79 100 22];

            % Create bSpinnerLabel
            app.bSpinnerLabel = uilabel(app.PencerahanCitraPanel);
            app.bSpinnerLabel.HorizontalAlignment = 'right';
            app.bSpinnerLabel.Position = [13 44 25 22];
            app.bSpinnerLabel.Text = 'b';

            % Create bSpinner
            app.bSpinner = uispinner(app.PencerahanCitraPanel);
            app.bSpinner.Enable = 'off';
            app.bSpinner.Position = [53 44 100 22];

            % Create ParameterLabel
            app.ParameterLabel = uilabel(app.PencerahanCitraPanel);
            app.ParameterLabel.Position = [11 110 61 22];
            app.ParameterLabel.Text = 'Parameter';

            % Create ProsesPencerahanCitraButton
            app.ProsesPencerahanCitraButton = uibutton(app.PencerahanCitraPanel, 'push');
            app.ProsesPencerahanCitraButton.ButtonPushedFcn = createCallbackFcn(app, @ProsesPencerahanCitraButtonPushed, true);
            app.ProsesPencerahanCitraButton.Enable = 'off';
            app.ProsesPencerahanCitraButton.Position = [22 9 149 23];
            app.ProsesPencerahanCitraButton.Text = 'Proses Pencerahan Citra';

            % Create PembalikanCitraPanel
            app.PembalikanCitraPanel = uipanel(app.PerbaikanKualitasTab);
            app.PembalikanCitraPanel.Title = 'Pembalikan Citra';
            app.PembalikanCitraPanel.Position = [42 220 192 63];

            % Create ProsesBalikanCitraButton
            app.ProsesBalikanCitraButton = uibutton(app.PembalikanCitraPanel, 'push');
            app.ProsesBalikanCitraButton.ButtonPushedFcn = createCallbackFcn(app, @ProsesBalikanCitraButtonPushed, true);
            app.ProsesBalikanCitraButton.Enable = 'off';
            app.ProsesBalikanCitraButton.Position = [34 11 124 23];
            app.ProsesBalikanCitraButton.Text = 'Proses Balikan Citra';

            % Create TransformasiLogPanel
            app.TransformasiLogPanel = uipanel(app.PerbaikanKualitasTab);
            app.TransformasiLogPanel.Title = 'Transformasi Log';
            app.TransformasiLogPanel.Position = [43 44 192 130];

            % Create cSpinnerLabel
            app.cSpinnerLabel = uilabel(app.TransformasiLogPanel);
            app.cSpinnerLabel.HorizontalAlignment = 'right';
            app.cSpinnerLabel.Position = [13 48 25 22];
            app.cSpinnerLabel.Text = 'c';

            % Create cSpinner
            app.cSpinner = uispinner(app.TransformasiLogPanel);
            app.cSpinner.Limits = [0 Inf];
            app.cSpinner.Enable = 'off';
            app.cSpinner.Position = [53 48 100 22];

            % Create ParameterLabel_2
            app.ParameterLabel_2 = uilabel(app.TransformasiLogPanel);
            app.ParameterLabel_2.Position = [11 79 61 22];
            app.ParameterLabel_2.Text = 'Parameter';

            % Create ProsesTransformasiLogButton
            app.ProsesTransformasiLogButton = uibutton(app.TransformasiLogPanel, 'push');
            app.ProsesTransformasiLogButton.ButtonPushedFcn = createCallbackFcn(app, @ProsesTransformasiLogButtonPushed, true);
            app.ProsesTransformasiLogButton.Enable = 'off';
            app.ProsesTransformasiLogButton.Position = [22 13 148 23];
            app.ProsesTransformasiLogButton.Text = 'Proses Transformasi Log';

            % Create TransformasiPangkatPanel
            app.TransformasiPangkatPanel = uipanel(app.PerbaikanKualitasTab);
            app.TransformasiPangkatPanel.Title = 'Transformasi Pangkat';
            app.TransformasiPangkatPanel.Position = [254 13 192 161];

            % Create cSpinner_2Label
            app.cSpinner_2Label = uilabel(app.TransformasiPangkatPanel);
            app.cSpinner_2Label.HorizontalAlignment = 'right';
            app.cSpinner_2Label.Position = [13 79 25 22];
            app.cSpinner_2Label.Text = 'c';

            % Create cSpinner_2
            app.cSpinner_2 = uispinner(app.TransformasiPangkatPanel);
            app.cSpinner_2.Limits = [0 Inf];
            app.cSpinner_2.Enable = 'off';
            app.cSpinner_2.Position = [53 79 100 22];

            % Create Label
            app.Label = uilabel(app.TransformasiPangkatPanel);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [4 44 45 22];
            app.Label.Text = 'gamma';

            % Create gammaSpinner
            app.gammaSpinner = uispinner(app.TransformasiPangkatPanel);
            app.gammaSpinner.Step = 0.1;
            app.gammaSpinner.Limits = [0 Inf];
            app.gammaSpinner.Enable = 'off';
            app.gammaSpinner.Position = [53 44 100 22];

            % Create ParameterLabel_3
            app.ParameterLabel_3 = uilabel(app.TransformasiPangkatPanel);
            app.ParameterLabel_3.Position = [11 110 61 22];
            app.ParameterLabel_3.Text = 'Parameter';

            % Create ProsesTransformasiPangkatButton
            app.ProsesTransformasiPangkatButton = uibutton(app.TransformasiPangkatPanel, 'push');
            app.ProsesTransformasiPangkatButton.ButtonPushedFcn = createCallbackFcn(app, @ProsesTransformasiPangkatButtonPushed, true);
            app.ProsesTransformasiPangkatButton.Enable = 'off';
            app.ProsesTransformasiPangkatButton.Position = [11 9 172 23];
            app.ProsesTransformasiPangkatButton.Text = 'Proses Transformasi Pangkat';

            % Create PereganganKontrasPanel
            app.PereganganKontrasPanel = uipanel(app.PerbaikanKualitasTab);
            app.PereganganKontrasPanel.Title = 'Peregangan Kontras';
            app.PereganganKontrasPanel.Position = [466 111 192 63];

            % Create ProsesPereganganKontrasButton
            app.ProsesPereganganKontrasButton = uibutton(app.PereganganKontrasPanel, 'push');
            app.ProsesPereganganKontrasButton.ButtonPushedFcn = createCallbackFcn(app, @ProsesPereganganKontrasButtonPushed, true);
            app.ProsesPereganganKontrasButton.Enable = 'off';
            app.ProsesPereganganKontrasButton.Position = [13 11 166 23];
            app.ProsesPereganganKontrasButton.Text = 'Proses Peregangan Kontras';

            % Create PerataanHistogramTab
            app.PerataanHistogramTab = uitab(app.TabGroup);
            app.PerataanHistogramTab.Title = 'Perataan Histogram';

            % Create ImageAxes_3
            app.ImageAxes_3 = uiaxes(app.PerataanHistogramTab);
            app.ImageAxes_3.XTick = [];
            app.ImageAxes_3.YTick = [];
            app.ImageAxes_3.Position = [42 22 649 423];

            % Create CitramasukanLabel_3
            app.CitramasukanLabel_3 = uilabel(app.PerataanHistogramTab);
            app.CitramasukanLabel_3.Position = [41 531 86 22];
            app.CitramasukanLabel_3.Text = 'Citra masukan:';

            % Create PilihFileCitraButton_3
            app.PilihFileCitraButton_3 = uibutton(app.PerataanHistogramTab, 'push');
            app.PilihFileCitraButton_3.ButtonPushedFcn = createCallbackFcn(app, @PilihFileCitraButton_3Pushed, true);
            app.PilihFileCitraButton_3.Position = [133 531 100 23];
            app.PilihFileCitraButton_3.Text = 'Pilih File Citra';

            % Create TampilkanHasilButton
            app.TampilkanHasilButton = uibutton(app.PerataanHistogramTab, 'push');
            app.TampilkanHasilButton.ButtonPushedFcn = createCallbackFcn(app, @TampilkanHasilButtonPushed, true);
            app.TampilkanHasilButton.Enable = 'off';
            app.TampilkanHasilButton.Position = [531 531 127 23];
            app.TampilkanHasilButton.Text = 'Tampilkan Hasil';

            % Create PathcitraLabel_3
            app.PathcitraLabel_3 = uilabel(app.PerataanHistogramTab);
            app.PathcitraLabel_3.Position = [41 502 59 22];
            app.PathcitraLabel_3.Text = 'Path citra:';

            % Create PathInfoLabel_3
            app.PathInfoLabel_3 = uilabel(app.PerataanHistogramTab);
            app.PathInfoLabel_3.Position = [111 502 441 22];
            app.PathInfoLabel_3.Text = '';

            % Create PreviewCitraMasukanLabel_3
            app.PreviewCitraMasukanLabel_3 = uilabel(app.PerataanHistogramTab);
            app.PreviewCitraMasukanLabel_3.Position = [306 456 128 22];
            app.PreviewCitraMasukanLabel_3.Text = 'Preview Citra Masukan';

            % Create HistogramSpecificationTab
            app.HistogramSpecificationTab = uitab(app.TabGroup);
            app.HistogramSpecificationTab.Title = 'Histogram Specification';

            % Create ImageAxes_4
            app.ImageAxes_4 = uiaxes(app.HistogramSpecificationTab);
            app.ImageAxes_4.XTick = [];
            app.ImageAxes_4.YTick = [];
            app.ImageAxes_4.Position = [25 22 340 381];

            % Create ImageAxes_5
            app.ImageAxes_5 = uiaxes(app.HistogramSpecificationTab);
            app.ImageAxes_5.XTick = [];
            app.ImageAxes_5.YTick = [];
            app.ImageAxes_5.Position = [364 22 340 381];

            % Create CitramasukanLabel_4
            app.CitramasukanLabel_4 = uilabel(app.HistogramSpecificationTab);
            app.CitramasukanLabel_4.Position = [41 531 86 22];
            app.CitramasukanLabel_4.Text = 'Citra masukan:';

            % Create PilihFileCitraButton_4
            app.PilihFileCitraButton_4 = uibutton(app.HistogramSpecificationTab, 'push');
            app.PilihFileCitraButton_4.ButtonPushedFcn = createCallbackFcn(app, @PilihFileCitraButton_4Pushed, true);
            app.PilihFileCitraButton_4.Position = [133 531 100 23];
            app.PilihFileCitraButton_4.Text = 'Pilih File Citra';

            % Create TampilkanHasilButton_2
            app.TampilkanHasilButton_2 = uibutton(app.HistogramSpecificationTab, 'push');
            app.TampilkanHasilButton_2.ButtonPushedFcn = createCallbackFcn(app, @TampilkanHasilButton_2Pushed, true);
            app.TampilkanHasilButton_2.Enable = 'off';
            app.TampilkanHasilButton_2.Position = [531 531 127 23];
            app.TampilkanHasilButton_2.Text = 'Tampilkan Hasil';

            % Create PathcitraLabel_4
            app.PathcitraLabel_4 = uilabel(app.HistogramSpecificationTab);
            app.PathcitraLabel_4.Position = [41 502 59 22];
            app.PathcitraLabel_4.Text = 'Path citra:';

            % Create PathInfoLabel_4
            app.PathInfoLabel_4 = uilabel(app.HistogramSpecificationTab);
            app.PathInfoLabel_4.Position = [146 502 406 22];
            app.PathInfoLabel_4.Text = '';

            % Create PreviewCitraMasukanLabel_4
            app.PreviewCitraMasukanLabel_4 = uilabel(app.HistogramSpecificationTab);
            app.PreviewCitraMasukanLabel_4.Position = [127 402 128 22];
            app.PreviewCitraMasukanLabel_4.Text = 'Preview Citra Masukan';

            % Create PreviewCitraAcuanLabel
            app.PreviewCitraAcuanLabel = uilabel(app.HistogramSpecificationTab);
            app.PreviewCitraAcuanLabel.Position = [496 402 113 22];
            app.PreviewCitraAcuanLabel.Text = 'Preview Citra Acuan';

            % Create CitraacuanLabel
            app.CitraacuanLabel = uilabel(app.HistogramSpecificationTab);
            app.CitraacuanLabel.Position = [41 473 70 22];
            app.CitraacuanLabel.Text = 'Citra acuan:';

            % Create PilihFileAcuanButton
            app.PilihFileAcuanButton = uibutton(app.HistogramSpecificationTab, 'push');
            app.PilihFileAcuanButton.ButtonPushedFcn = createCallbackFcn(app, @PilihFileAcuanButtonPushed, true);
            app.PilihFileAcuanButton.Position = [133 473 100 23];
            app.PilihFileAcuanButton.Text = 'Pilih File Acuan';

            % Create PathcitraacuanLabel
            app.PathcitraacuanLabel = uilabel(app.HistogramSpecificationTab);
            app.PathcitraacuanLabel.Position = [41 444 96 22];
            app.PathcitraacuanLabel.Text = 'Path citra acuan:';

            % Create PathInfoLabel_5
            app.PathInfoLabel_5 = uilabel(app.HistogramSpecificationTab);
            app.PathInfoLabel_5.Position = [146 444 406 22];
            app.PathInfoLabel_5.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end