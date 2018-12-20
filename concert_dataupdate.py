#!C:\Python\Python36\python.exe
#-*-coding: utf-8 -*-

import requests
import operator
import pandas
import glob2
from bs4 import BeautifulSoup
from datetime import datetime
import csv
import numpy as np
import cx_Oracle as co

print("content-type: text/html; charset=utf-8\n")

num = 0

while num < 1 :
    num = num +1

    # 크롤링 함수(날짜와 페이지수를 입력받아 그날짜의 그 페이지수만큼 크롤링 해옴)
    def crawling(pageCount):

        # 현재 시각을 now라는 변수에 저장
        now=datetime.now()
        l=[]    # 리스트 l

        # pagecount는 1페이지부터 사용자가 입력한 페이지 수까지 됨
        for i in range(1,int(pageCount)):

            # 동적으로, 사용자가 입력한 페이지에 접속
            r = requests.get("http://www.playdb.co.kr/playdb/playdblist.asp?Page="+str(i)+"&sReqMainCategory=000003&sReqSubCategory=&sReqDistrict=&sReqTab=2&sPlayType=3&sStartYear=&sSelectType=")
            c = r.content
            soup = BeautifulSoup(c,"html.parser")

            lists = soup.find_all('table',{'width':'480'})
            for list in lists:
                d={}    # 사전

                # 타이틀,장르,날짜,장소,출연
                try:
                    title=list.find("a",{"href":"#"}).text.replace(" ","").replace(",","&")
                    # links=list.find("a",{"href":"#"})['oneclick']
                    sub=list.text.split('세부장르')
                    sub=sub[1]
                    sub=sub.replace(" : ","").replace("일시","*").replace("장소","*").replace("출연","*").replace("\n","")
                    sub=sub.split("*")
                    d["title"]=title
                    d["genre"]=sub[0]
                    d["date"]=sub[1]
                    d["loc"]=sub[2]
                    d["artist"]=sub[3]

                except:
                    d["title"]="None"
                    d["genre"]="None"
                    d["date"]="None"
                    d["loc"]="None"
                    d["artist"]="None"

                # 이미지
                try:
                    img=list.find("div",{"align":"center"}).find("img")['src']
                    d["imgSrc"]=img
                except:
                    d["imgSrc"]="None"

                l.append(d) # 리스트에 사전 추가 / 한 행마다 사전에 추가

        df=pandas.DataFrame(l)  # pandas 사용 l의 데이터프레임화

        # None 제외
        df = df[df["title"] != "None"]
        df = df[df["genre"] != "None"]
        df = df[df["date"] != "None"]
        df = df[df["loc"] != "None"]
        df = df[df["artist"] != "None"]
        df = df[df["imgSrc"] != "None"]

        # isShow 추가
        df["isshow"] = "Y"

        # cno 추가
        df["cno"] = np.arange(len(df))+1

        # now(현재시각)을 이용해 csv 파일로 저장
        df.to_csv('E:\\sound\\%s-%s-%s-%s-%s-%s.csv' % (now.year, now.month, now.day, now.hour, now.minute, now.second),encoding='utf-8-sig', index=False)

        print("Crawling End")
        print("Data file save success")

        df.to_csv('E:\\sound\\updateFile.csv', encoding='utf-8-sig', index=False)

        print("Update file save success")

        conncectdb()

    #csv파일 db에 저장
    def conncectdb():
        print("Connect DB Start")

        conn = co.connect('sound/music@localhost:1521/xe')

        db = conn.cursor()

        db.execute('DELETE from CONCERT')
        conn.commit()

        cnt=0
        with open('E:\\sound\\updateFile.csv','r',encoding='utf-8-sig') as f:
            while True:
                cnt=cnt+1
                line=f.readline()
                if cnt==1:
                    continue
                if not line:
                    break
                line=line.replace(', ','*')
                line=line.replace(',','#')
                line=line.replace('*',', ')
                line=line.replace('\n','')
                line=line.replace('"','')
                line=line.split('#')
                # print(line)
                sql = 'INSERT INTO CONCERT (C_ARTIST,C_DATE,C_GENRE,C_IMGSRC,C_LOC,C_TITLE,C_ISSHOW,C_CNO) values (:0, :1, :2, :3, :4, :5, :6, :7)'
                db.execute(sql, (line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7]))
                conn.commit()

        db.close()
        conn.close()

        print("Connect DB End")

    def mainSetting():

                print("Crawling Start")

                # pageCount 구하기
                r = requests.get("http://www.playdb.co.kr/playdb/playdblist.asp?sReqMainCategory=000003")
                c = r.content
                soup = BeautifulSoup(c,"html.parser")

                tags = soup.find_all('td', {'height': '25'})
                for tag in tags:
                    d = {}
                    # print(tag)
                    page = tag.text.split('</td>')
                    page = page[0].replace("|", "").split(" ")
                pageCount = page[21].replace("1/", "").replace("]", "")

                crawling(pageCount)

    def main():

        mainSetting()

    if __name__=='__main__':

        main()

    if num != 0:
        print("Exit")
        break
