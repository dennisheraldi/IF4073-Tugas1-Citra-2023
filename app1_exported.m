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
    end

    
    methods (Access = public)
        
        function imagehistogram(~,img,name)
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

                % Menampilkan histogram Grayscale dalam jendela popup
                figure('Name', ['Histogram Citra Grayscale dari',' ', name], 'NumberTitle', 'off');
                bar(histValues);
                xlabel('Derajat Keabuan');
                ylabel('Frekuensi');

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
            title('Citra Hasil')
            
            % Menampilkan histogram pada masing-masing citra
            app.imagehistogram(img1, 'Citra Masukan')
            app.imagehistogram(img2, 'Citra Hasil')
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
        function PilihFileCitraButtonPushed(app, ~)
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
        function TampilkanHistogramButtonPushed(app, ~)
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
        function PilihFileCitraButton_2Pushed(app, ~)
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
        function ProsesPencerahanCitraButtonPushed(app, ~)
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
        function ProsesBalikanCitraButtonPushed(app, ~)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            result = app.pembalikancitra(img);

            % Menampilkan perbandingan citra asli dan hasil balikan
            app.perbandinganduacitra('Perbandingan Hasil Pembalikan Citra', img, result);
        end

        % Button pushed function: ProsesTransformasiLogButton
        function ProsesTransformasiLogButtonPushed(app, ~)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            c = app.cSpinner.Value;
            result = app.transformasilog(img,c);

            % Menampilkan perbandingan citra asli dan hasil transformasi
            app.perbandinganduacitra('Perbandingan Hasil Transformasi Log Citra', img, result);
        end

        % Button pushed function: ProsesTransformasiPangkatButton
        function ProsesTransformasiPangkatButtonPushed(app, ~)
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
        function ProsesPereganganKontrasButtonPushed(app, ~)
            % Mendapatkan citra masukan dari path
            img = imread(app.PathInfoLabel_2.Text);
            
            % Citra luaran
            result = app.peregangankontras(img);

            % Menampilkan perbandingan citra asli dan hasil transformasi
            app.perbandinganduacitra('Perbandingan Hasil Peregangan Kontras', img, result);
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